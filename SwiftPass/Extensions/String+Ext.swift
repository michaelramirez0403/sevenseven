//
//  String+Ext.swift
//  
//
//  Created by Michael Ramirez on 10/21/24.
//
import Foundation
extension String {
    var isValidUserame: Bool {
        let regEx = TitleLabel.validUsername
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
    var isValidPassword: Bool {
        let regEx = TitleLabel.validPassword
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
}
