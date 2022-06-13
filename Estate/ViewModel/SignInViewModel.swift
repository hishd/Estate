//
//  SignInViewModel.swift
//  NIBM Broker
//
//  Created by Hishara Dilshan on 2022-03-27.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var showSignUpView = false
    @Published var isError = false
    @Published var errorCaption = ""
    
    // MARK: - Input Field Validations
    @Published var isValidEmail = true
    @Published var isValidPassword = true
    
    @Published var emailAddress: String = ""
    @Published var password: String = ""
    
    private var settingsEO: UserSettings?
    
    func setSettingsEO(eo: UserSettings) {
        self.settingsEO = eo
    }
}

extension SignInViewModel {
    
    @MainActor
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
}

// MARK: Concrete Methods
extension SignInViewModel: AuthenticationService {
    @MainActor
    func performSignIn() async {
        do {
            let (result) = try await User().signIn(emailAddress: emailAddress, password: password)
            DispatchQueue.main.async {
                self.isError = false
            }
            if result {
                if let user = try await User().getUserData(of: emailAddress) {
                    UserSettings.shared.authState = true
                    try UserSettings.shared.saveUserSession(for: user)
                    self.settingsEO?.loggedIn = true
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
            isError = true
            errorCaption = error.localizedDescription
        }
    }
}
