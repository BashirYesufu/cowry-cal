//
//  DashboardViewModel.swift
//  cowry-cal
//
//  Created by Bash on 13/07/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class DashboardViewModel {
    
    func makeAPIRequest(url: URL, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    let apiKey = ""
    
    let error = PublishSubject<String>()
    let progress = BehaviorRelay<Bool>(value: false)
    let currencySymbolsResponse: PublishRelay<[String: String]> = PublishRelay()
    let currencyConversionResponse: PublishRelay<ConversionResponse> = PublishRelay()
    
    func getAllSymbols(){
        progress.accept(true)
        makeAPIRequest(
            url: URL(string: "http://data.fixer.io/api/symbols?access_key=\(apiKey)")!,
            method: .get,
            parameters: nil,
            headers: nil) { result in
                switch result {
                    
                case .success(let data):
                    self.progress.accept(false)
                    let json = JSON(data)
                    let currencySymbols = CurrencySymbols(json: json)
                    if currencySymbols.success {
                        self.currencySymbolsResponse.accept(currencySymbols.symbols)
                    } else {
                        self.error.onNext("Unable to get currencies")
                    }
                    
                case .failure(let error):
                    self.progress.accept(false)
                    print(error.localizedDescription)
                    
                }
            }
    }
    
    func convert(from: String, to: String, amount: Int){
        
        if from.isEmpty {
            self.error.onNext("KIndly select a currency to convert from")
            return
        }
        
        if to.isEmpty {
            self.error.onNext("KIndly select a currency to convert to")
            return
        }
        
        if !from.isEmpty && from == to {
            self.error.onNext("Cannot convert same currency pairs")
            return
        }
        
        if !(amount > 0) {
            self.error.onNext("KIndly enter an amount greater than 0")
            return
        }
        progress.accept(true)
        makeAPIRequest(
            url: URL(string: "http://data.fixer.io/api/convert?access_key=\(apiKey)&from=\(from)&to=\(to)&amount=\(amount)")!,
            method: .get,
            parameters: nil,
            headers: nil) { result in
                switch result {
                    
                case .success(let data):
                    self.progress.accept(false)
                    let json = JSON(data)
                    let response = ConversionResponse(json: json)
                    if response.success {
                        self.currencyConversionResponse.accept(response)
                    } else {
                        self.error.onNext(response.error?.info ?? "Error converting currencies")
                    }
                    
                case .failure(let error):
                    self.progress.accept(false)
                    self.error.onNext(error.localizedDescription)
                }
            }
    }
    
//http://data.fixer.io/api/fluctuation
//    ? access_key = 47e6a4a2c888adedce7afa9930d091c4
//    & start_date = 2015-12-01
//    & end_date = 2015-12-24
    
}
