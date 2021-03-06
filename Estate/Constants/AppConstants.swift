//
//  AppConstants.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-02.
//

import Foundation


enum ValidationCaptions: String {
    case invalidNIC = "Invalid NIC no."
    case invalidName = "Invalid person name"
    case invalidMobileNo = "Invalid Mobile no."
    case invalidEmail = "Invalid Email Address"
    case invalidLocation = "Please turn on location & press load"
    case invalidPassword = "Password minimum length is 8"
    case passwordsNoMatch = "Passwords don't match"
    case invalidPrice = "Invalid Price"
    case invalidLandSize = "Invalid Land Size"
    case invalidTown = "Invalid Town"
    case invalidInformation = "Invalid Information"
}

enum SessionManagerKeys: String {
    case userSession = "USER_SESSION"
    case authState = "AUTH_STATE"
}
