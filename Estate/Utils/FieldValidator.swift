//
//  FieldValidator.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-31.
//

import Foundation

class FieldValidator {
    static let shared = FieldValidator()
    private init() {}
    
    lazy var namePredicate = NSPredicate(format: "SELF MATCHES %@", Patterns.nameRegex.rawValue)
    lazy var emailPredicate = NSPredicate(format: "SELF MATCHES %@", Patterns.emailRegex.rawValue)
    lazy var mobilePredicate = NSPredicate(format: "SELF MATCHES %@", Patterns.mobileRegex.rawValue)
    lazy var nicPredicate = NSPredicate(format: "SELF MATCHES %@", Patterns.nicRegex.rawValue)
    
    func isValidPersonName(of name: String) -> Bool {
        return self.namePredicate.evaluate(with: name)
    }
    
    func isValidEmailAddress(of email: String) -> Bool {
        return self.emailPredicate.evaluate(with: email)
    }
    
    func isValidMobileNo(of mobileNo: String) -> Bool {
        return self.mobilePredicate.evaluate(with: mobileNo)
    }
    
    func isValidNIC(of nic: String) -> Bool {
        return self.nicPredicate.evaluate(with: nic)
    }
}

enum Patterns: String {
    case nameRegex = "[A-Za-z ]{2,100}"
    case emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case mobileRegex = "^[0-9]{5,20}$"
    case nicRegex = "^([0-9]{9}[x|X|v|V]|[0-9]{12})$"
}
