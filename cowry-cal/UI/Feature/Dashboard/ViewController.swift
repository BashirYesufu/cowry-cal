//
//  ViewController.swift
//  cowry-cal
//
//  Created by Bash on 12/07/2023.
//

import UIKit
import RxSwift
import ActionSheetPicker_3_0

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
    
    private let viewModel = DashboardViewModel()
    let disposeBag = DisposeBag()
    private var symbols = [String]()
    private var currencySymbols = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
    
    private func setupUI(){
        fromView.addTapGestureRecognizer { [self] in
            ActionSheetStringPicker.show(withTitle: "Pick a currency", rows: self.symbols, initialSelection: 0, doneBlock: { picker, index, item in
                self.fromViewLabel.text = item as? String
                self.fromCurrency.text = item as? String
                return
            }, cancel: nil, origin: self.fromView.superview!.superview)
        }
        
        toView.addTapGestureRecognizer { [self] in
            ActionSheetStringPicker.show(withTitle: "Pick a currency", rows: self.symbols, initialSelection: 0, doneBlock: { picker, index, item in
                self.toViewLabel.text = item as? String
                self.toCurrency.text = item as? String
                return
            }, cancel: nil, origin: self.fromView.superview!.superview)
        }
        
        convertButton.addTapGestureRecognizer { [self] in
            self.viewModel.convert(from: fromCurrency.text ?? "", to: toCurrency.text ?? "", amount: Int(fromField.text ?? "0") ?? 0)
        }
    }
    
    private func bindViewModel(){
        viewModel.getAllSymbols()
        
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
        
    }


}

