//
//  Constant.swift
//  SwiftPass
//
//  Created by Michael Ramirez on 11/5/24.
//
import UIKit
let blank_ = ""
enum CustomColor {
    static let backgroundColor = UIColor(named: "BackgroundColor")
}
enum TitleLabel {
    static let title = "SwiftPass"
    static let signUp = "Sign Up"
    static let signIn = "Sign In"
    static let welcome = "Welcome!"
    static let success = "Success"
    static let error = "Error"
    static let notAvailable = "This feature is not available for the moment."
    static let ok = "Ok"
    static let backArrow = "arrow.left"
    static let signInButton = "Sign In"
    static let signUpButton = "Sign Up"
    static let logOutButton = "Log Out"
    static let forgotPasswordButton = "Forgot Password?"
    static let connectWith = "Or connect with"
    static let validUsername = "^\\S+@\\S+\\.\\S+$"
    // MARK: - REGEX:
    //    length 8 character, one uppercase letter, one number
    static let validPassword = #"(?=^.{8,}$)(?=^.*[A-Z].*$)(?=^.*\d.*$).*"#
    static let username = "   Username"
    static let password = "   Password"
    static let passwordPlaceholder = "   Enter your password"
    static let usernamePlaceholder = "   Enter your username"
    static let enterUserName = "Please enter a valid username. We need to know who to look for 😀."
    static let enterPassword = "Please enter a valid password. We need to have a minimum of 8 characters, with one uppercase letter, one number to register or login 😀."
    static let foodDescription = "Congratutions you have reached the homepage!"
}
enum Images {
    static let burgerImage = UIImage(named: "burger")
    static let fancyImage = UIImage(named: "fancy")
    static let fImage = UIImage(named: "fIcon")
    static let gImage = UIImage(named: "gIcon")
    static let delicous = UIImage(named: "delicous")
}
