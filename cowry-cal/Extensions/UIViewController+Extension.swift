//
//  UIViewController+Extension.swift
//  cowry-cal
//
//  Created by Bash on 13/07/2023.
//

import UIKit
import MaterialComponents
import ProgressHUD

extension UIViewController {
    func showProgressIndicator(){
        ProgressHUD.show()
    }
    
    func dismissProgressIndicator(){
        ProgressHUD.dismiss()
    }
    
    func showError(_ message:String){
        let snackMessage = MDCSnackbarMessage(text: message)
        MDCSnackbarManager.messageTextColor = .white
        MDCSnackbarManager.messageFont = R.font.montserratAlternatesRegular(size: 14)!
        MDCSnackbarManager.snackbarMessageViewBackgroundColor = .red
        MDCSnackbarManager.show(snackMessage)
    }
}
