//
//  SignInViewModel.swift
//  NIBM Broker
//
//  Created by Hishara Dilshan on 2022-03-27.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var user = User()
    @Published var showSignUpView = false
    @Published var isSignedIn = false
    
    // MARK: - Input Field Validations
    @Published var isValidEmail = true
    @Published var isValidPassword = true
}

extension SignInViewModel {
    private func validateInput() -> Bool {
        if !FieldValidator.shared.isValidEmailAddress(of: user.emailAddress) {
            isValidEmail = false
            return false
        }
        
        if !FieldValidator.shared.isValidPassword(of: user.password) {
            isValidPassword = false
            return false
        }
        
        return true
    }
    
    func userSignIn() {
        
    }
}
