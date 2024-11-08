//
//  UIViewController+Ext.swift
//
//  Created by Michael Ramirez on 9/30/24.
//
//
import UIKit
extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async { [unowned self] in
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: buttonTitle, style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
