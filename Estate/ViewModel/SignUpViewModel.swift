//
//  SignUpViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-30.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var user = User()
    @Published var isMale: Bool = true
    @Published var location: String = ""
    @Published var confPassword: String = ""
    
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
        if !FieldValidator.shared.isValidNIC(of: user.nicNo) {
            isValidNIC = false
            return false
        }
        if !FieldValidator.shared.isValidPersonName(of: user.name) {
            isValidName = false
            return false
        }
        if !FieldValidator.shared.isValidMobileNo(of: user.mobileNo) {
            isValidMobile = false
            return false
        }
        if location.isEmpty {
            isValidLocation = false
            return false
        }
        if !FieldValidator.shared.isValidEmailAddress(of: user.emailAddress) {
            isValidEmail = false
            return false
        }
        if !FieldValidator.shared.isValidPassword(of: user.password) {
            isValidPassword = false
            return false
        }
        if user.password.elementsEqual(confPassword) {
            isMatchingPasswords = false
            return false
        }
        
        return true
    }
    
    func registeruser() {
        //Final check of the input fields
        if validateInput() {
            //Process Gender, Location before sending the user instance
        }
    }
}
