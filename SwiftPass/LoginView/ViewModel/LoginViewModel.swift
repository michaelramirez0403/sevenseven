//
//  LoginViewModel.swift
//  SwiftPass
//
//  Created by Macky Ramirez on 11/6/24.
//

import Foundation
import CoreData
class LoginViewModel: BaseViewModel {
    var usernameText = String()
    var passwordText = String()
    var isUsernameEntered: Bool { return !usernameText.isEmpty && usernameText.isValidUserame }
    var isPasswordEntered: Bool { return !passwordText.isEmpty && passwordText.isValidPassword }
    func login() {
        let existingUser = CoreDataManager.sharedManager.checkIfItemExist(usernameText,
                                                                          passwordText)
        if !existingUser {
            delegate?.didRequestFailed("Login Failed: Your user ID or password is incorrect.")
            return
        }
        delegate?.loading()
        let simulatedNetworkLatency = Double.random(in: 1...3)
        DispatchQueue.global().asyncAfter(deadline: .now() + simulatedNetworkLatency) {
            DispatchQueue.main.async {
                self.delegate?.didRequestSuccess("Push to another controller.")
            }
        }
    }
}
