//
//  ViewController.swift
//  cowry-cal
//
//  Created by Bash on 12/07/2023.
//

import UIKit
import RxSwift
import ActionSheetPicker_3_0
import DGCharts
import CountryKit

class ViewController: UIViewController {

    
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var fromCurrency: UILabel!
    @IBOutlet weak var toField: UITextField!
    @IBOutlet weak var toCurrency: UILabel!
    
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    
    @IBOutlet weak var fromFlag: UIImageView!
    @IBOutlet weak var toFlag: UIImageView!
    
    @IBOutlet weak var fromViewLabel: UILabel!
    @IBOutlet weak var toViewLabel: UILabel!
    
    @IBOutlet weak var convertButton: UIView!
    
    @IBOutlet weak var charts: LineChartView!
    @IBOutlet weak var thirtyDay: UILabel!
    @IBOutlet weak var thirtyDayIndicator: UIView!
    @IBOutlet weak var sixtyDay: UILabel!
    @IBOutlet weak var sixtyDayIndicator: UIView!
    
    
    private let viewModel = DashboardViewModel()
    let disposeBag = DisposeBag()
    private var symbols = [String]()
    private var currencySymbols = [String: String]()
    private var sets = [LineChartDataSet]()
    private let countryKit = CountryKit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        addGestures()
        setupUI()
    }
    
    private func addGestures(){
        fromView.addTapGestureRecognizer { [self] in
            ActionSheetStringPicker.show(withTitle: "Pick a currency", rows: self.symbols, initialSelection: 0, doneBlock: { picker, index, item in
                self.fromViewLabel.text = item as? String
                self.fromCurrency.text = item as? String
                let count = self.countryKit.countries
                for country in count {
                    
                    let currencyCode = self.currencySymbols[item as! String]!
                    let countryCode = String(currencyCode.prefix(2))
                    let countryName = Locale.current.localizedString(forRegionCode: countryCode)
                    
                    if let countryName = countryName, countryName.lowercased() == country.localizedName.lowercased(){
                        self.fromFlag.image = country.flagImage
                        return
                    }
                    
                }
                return
            }, cancel: nil, origin: self.fromView.superview!.superview)
        }
        
        toView.addTapGestureRecognizer { [self] in
            ActionSheetStringPicker.show(withTitle: "Pick a currency", rows: self.symbols, initialSelection: 0, doneBlock: { picker, index, item in
                self.toViewLabel.text = item as? String
                self.toCurrency.text = item as? String
                let count = self.countryKit.countries
                for country in count {
                    
                    let currencyCode = self.currencySymbols[item as! String]!
                    let countryCode = String(currencyCode.prefix(2))
                    let countryName = Locale.current.localizedString(forRegionCode: countryCode)
                    
                    if let countryName = countryName, countryName.lowercased() == country.localizedName.lowercased(){
                        self.toFlag.image = country.flagImage
                        return
                    }
                    
                }
                return
            }, cancel: nil, origin: self.fromView.superview!.superview)
        }
        
        convertButton.addTapGestureRecognizer { [self] in
            self.viewModel.convert(from: fromCurrency.text ?? "", to: toCurrency.text ?? "", amount: Int(fromField.text ?? "0") ?? 0)
        }
        
        thirtyDay.addTapGestureRecognizer { [self] in
            sixtyDay.textColor = .lightGray
            sixtyDayIndicator.backgroundColor = R.color.cowryBlue()!
            thirtyDay.textColor = .white
            thirtyDayIndicator.backgroundColor = R.color.cowryGreen()!
            viewModel.getDayFluctuation(days: 30)
        }
        
        sixtyDay.addTapGestureRecognizer { [self] in
            thirtyDay.textColor = .lightGray
            thirtyDayIndicator.backgroundColor = R.color.cowryBlue()!
            sixtyDay.textColor = .white
            sixtyDayIndicator.backgroundColor = R.color.cowryGreen()!
            viewModel.getDayFluctuation(days: 60)
        }
    }
    
    private func setupUI(){
        sixtyDay.textColor = .lightGray
        sixtyDayIndicator.backgroundColor = R.color.cowryBlue()!
        charts.noDataText = "No data available"
        charts.xAxis.drawGridLinesEnabled = false
        charts.rightAxis.drawGridLinesEnabled = false
        charts.leftAxis.drawGridLinesEnabled = true
        charts.xAxis.drawAxisLineEnabled = false
        charts.rightAxis.drawAxisLineEnabled = false
        charts.leftAxis.drawAxisLineEnabled = true
        charts.leftAxis.drawLabelsEnabled = true
        charts.rightAxis.drawLabelsEnabled = false
        charts.xAxis.drawLabelsEnabled = true
        charts.xAxis.centerAxisLabelsEnabled = true
        
        let data = LineChartData(dataSets: sets)
        charts.data = data
    }
    
    private func bindViewModel(){
        viewModel.getAllSymbols()
        viewModel.getDayFluctuation(days: 30)
        
        viewModel.progress.bind { progress in
            progress ? self.showProgressIndicator() : self.dismissProgressIndicator()
        }.disposed(by: disposeBag)
        
        viewModel.currencySymbolsResponse.bind { response in
            self.currencySymbols = response
            self.symbols = response.map({ sym in
                sym.key
            })
        }.disposed(by: disposeBag)
        
        viewModel.error.bind { error in
            self.showError(error)
        }.disposed(by: disposeBag)
        
        viewModel.currencyConversionResponse.bind { response in
            self.toField.text = "\(response.rate)"
        }.disposed(by: disposeBag)
        
        viewModel.fluctuationRateResponse.bind { [weak self] response in
            guard let self = self else {return}
            self.sets = []
            let _ = response.rates.map { rate in
                let set1 = LineChartDataSet(entries: [ChartDataEntry(x: rate.value.usd, y: 20)], label: "Days")
                let set2 = LineChartDataSet(entries: [ChartDataEntry(x: rate.value.aud, y: 20)], label: "Days")
                let set3 = LineChartDataSet(entries: [ChartDataEntry(x: rate.value.cad, y: 20)], label: "Days")
                self.sets.append(set1)
                self.sets.append(set2)
                self.sets.append(set3)
                self.charts.legend.resetCustom()
                self.charts.notifyDataSetChanged()
                self.charts.setNeedsDisplay()
            }
        }.disposed(by: disposeBag)
        
    }


}

