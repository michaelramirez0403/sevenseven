//
//  UIView+Ext.swift
//  
//
//  Created by Michael Ramirez on 9/30/24.
//
import UIKit
extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
