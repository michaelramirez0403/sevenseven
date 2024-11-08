//
//  RegisterViewModel.swift
//  SwiftPass
//
//  Created by Macky Ramirez on 11/6/24.
//

import Foundation
import CoreData
class RegisterViewModel: BaseViewModel {
    var usernameText = String()
    var passwordText = String()
    var isUsernameEntered: Bool { return !usernameText.isEmpty && usernameText.isValidUserame }
    var isPasswordEntered: Bool { return !passwordText.isEmpty && passwordText.isValidPassword }
    var people: [NSManagedObject] = []
    func saveToCoreData() {
        let existingUser = CoreDataManager.sharedManager.checkIfItemExist(usernameText,
                                                                          passwordText)
        if existingUser {
            delegate?.didRequestFailed("Email address is already registered.")
            return
        }
        delegate?.loading()
        let user = UsersDetails(email: usernameText,
                                password: passwordText)
        // Simulate the network call
        let simulatedNetworkLatency = Double.random(in: 1...3)
        DispatchQueue.global().asyncAfter(deadline: .now() + simulatedNetworkLatency) {
            DispatchQueue.main.async {
                CoreDataManager.sharedManager.insertUserDetails(user)
                self.delegate?.didRequestSuccess("You can now login.")
            }
        }
    }
}