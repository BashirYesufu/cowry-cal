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
    
    /// Displays progress indicator on view controllers when network call is in progress
    func showProgressIndicator(){
        ProgressHUD.show()
    }
    
    /// Dismiss progress indicator on view controllers when network call is done
    func dismissProgressIndicator(){
        ProgressHUD.dismiss()
    }
    
    /// Shows an error snack bar with message
    func showError(_ message:String){
        let snackMessage = MDCSnackbarMessage(text: message)
        MDCSnackbarManager.messageTextColor = .white
        MDCSnackbarManager.messageFont = R.font.montserratAlternatesRegular(size: 14)!
        MDCSnackbarManager.snackbarMessageViewBackgroundColor = .red
        MDCSnackbarManager.show(snackMessage)
    }
}
