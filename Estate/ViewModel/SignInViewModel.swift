//
//  SignInViewModel.swift
//  NIBM Broker
//
//  Created by Hishara Dilshan on 2022-03-27.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var showSignUpView = false
    @Published var isSignedIn = false
    @Published var isError = false
    @Published var errorCaption = ""
    
    // MARK: - Input Field Validations
    @Published var isValidEmail = true
    @Published var isValidPassword = true
    
    @Published var emailAddress: String = ""
    @Published var password: String = ""
}

extension SignInViewModel {
    private func validateInput() -> Bool {
        if !FieldValidator.shared.isValidEmailAddress(of: emailAddress) {
            isValidEmail = false
            return false
        }
        
        if !FieldValidator.shared.isValidPassword(of: password) {
            isValidPassword = false
            return false
        }
        
        return true
    }
    
    func userSignIn(emailAddress: String, password: String) {
        Task {
            do {
                let (result) = try await User().signIn(emailAddress: emailAddress, password: password)
                DispatchQueue.main.async {
                    self.isError = false
                    self.isSignedIn = result
                }
            } catch {
                debugPrint(error.localizedDescription)
                isError = true
                errorCaption = error.localizedDescription
            }
        }
    }
}
