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
    lazy var dobPredicate = NSPredicate(format: "SELF MATCHES %@", Patterns.dobRegex.rawValue)
    lazy var passwordPredicate = NSPredicate(format: "SELF MATCHES %@", Patterns.passwordRegex.rawValue)
    lazy var pricePredicate = NSPredicate(format: "SELF MATCHES %@", Patterns.priceRegex.rawValue)
    lazy var landSizePredicate = NSPredicate(format: "SELF MATCHES %@", Patterns.landSizeRegex.rawValue)
    lazy var townNamePredicate = NSPredicate(format: "SELF MATCHES %@", Patterns.townNameRegex.rawValue)
    lazy var addInformationPredicate = NSPredicate(format: "SELF MATCHES %@", Patterns.addInformationRegex.rawValue)
    
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
    
    func isValidDOB(of dob: String) -> Bool {
        return self.dobPredicate.evaluate(with: dob)
    }
    
    func isValidPassword(of password: String) -> Bool {
        return self.passwordPredicate.evaluate(with: password)
    }
    
    func isValidPrice(of price: String) -> Bool {
        return self.pricePredicate.evaluate(with: price)
    }
    
    func isValidLandSize(of size: String) -> Bool {
        return self.landSizePredicate.evaluate(with: size)
    }
    
    func isValidTownName(of name: String) -> Bool {
        return self.townNamePredicate.evaluate(with: name)
    }
    
    func isValidAddInfo(of info: String) -> Bool {
        return self.addInformationPredicate.evaluate(with: info)
    }
}

enum Patterns: String {
    case nameRegex = "[A-Za-z ]{2,100}"
    case emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case mobileRegex = "^[0-9]{5,20}$"
    case nicRegex = "^([0-9]{9}[x|X|v|V]|[0-9]{12})$"
    case dobRegex = "(?:0[1-9]|[12][0-9]|3[01])[-/.](?:0[1-9]|1[012])[-/.](?:19\\d{2}|20[01][0-9]|2020)"
    //Password should contain minimum 8 chars
    case passwordRegex = "[A-Za-z\\d]{8,}"
    case priceRegex = "[\\d]{2,}"
    case landSizeRegex = "[\\d]{,6}"
    case townNameRegex = "[A-Za-z]{2,30}"
    case addInformationRegex = "[A-Za-z ]{5,300}"
}
