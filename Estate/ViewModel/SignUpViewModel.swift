//
//  SignUpViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-30.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var emailAddress: String = ""
    @Published var nicNo: String = ""
    @Published var mobileNo: String = ""
    @Published var isMale: Bool = true
    @Published var dob: Date = Date()
    @Published var location: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    // MARK: - Input Field Validations
    @Published var isValidName: Bool = true
    @Published var isValidEmail: Bool = true
    @Published var isValidNIC: Bool = true
    @Published var isValidMobile: Bool = true
    @Published var isValidLocation: Bool = true
    @Published var isValidPassword: Bool = true
    @Published var isMatchingPasswords: Bool = true
}

extension SignUpViewModel {
    private func validateInput() -> Bool {
        if !FieldValidator.shared.isValidNIC(of: nicNo) {
            isValidNIC = false
            return false
        }
        if !FieldValidator.shared.isValidPersonName(of: name) {
            isValidName = false
            return false
        }
        if !FieldValidator.shared.isValidMobileNo(of: mobileNo) {
            isValidMobile = false
            return false
        }
        if location.isEmpty {
            isValidLocation = false
            return false
        }
        if !FieldValidator.shared.isValidEmailAddress(of: emailAddress) {
            isValidEmail = false
            return false
        }
        if !FieldValidator.shared.isValidPassword(of: password) {
            isValidPassword = false
            return false
        }
        if password.elementsEqual(confirmPassword) {
            isMatchingPasswords = false
            return false
        }
        
        return true
    }
    
    func registeruser() {
        //Final check of the input fields
        if validateInput() {
            //Process Gender, Location, DOB before sending the user instance
        }
    }
}
