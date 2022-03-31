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
    @Published var password: String = ""
    @Published var confPassword: String = ""
    @Published var signUpDisabled = true
    
    // MARK: - Input Field Validations
    @Published var isValidName: Bool = true
    @Published var isValidEmail: Bool = true
    @Published var isValidNIC: Bool = true
    @Published var isValidMobile: Bool = true
    @Published var isValidDOB: Bool = true
    @Published var isValidPassword: Bool = true
    @Published var isMatchingPasswords: Bool = true
}

extension SignUpViewModel {
    func validateData() {
        if !FieldValidator.shared.isValidNIC(of: user.nicNo) {
            isValidNIC = false
            return
        }
        if !FieldValidator.shared.isValidPersonName(of: user.name) {
            isValidName = false
            return
        }
        if !FieldValidator.shared.isValidMobileNo(of: user.mobileNo) {
            isValidMobile = false
            return
        }
        if !FieldValidator.shared.isValidEmailAddress(of: user.emailAddress) {
            isValidEmail = false
            return
        }
        
        //Disable the sign up button if validations failed
        signUpDisabled = false
    }
}
