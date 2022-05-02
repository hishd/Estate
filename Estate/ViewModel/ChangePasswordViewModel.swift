//
//  ChangePasswordViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-19.
//

import Foundation

class ChangePasswordViewModel: ObservableObject {
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    
    // MARK: Input Field Validations
    @Published var isCorrectCurrentPassword: Bool = true
    @Published var isValidPassword: Bool = true
    @Published var isMatchingPasswords: Bool = true
}

extension ChangePasswordViewModel {
    @MainActor
    func validateInput() -> Bool {
        if !checkCurrentPassword() {
            isCorrectCurrentPassword = false
            return false
        }
        if !FieldValidator.shared.isValidPassword(of: newPassword) {
            isValidPassword = false
            return false
        }
        if newPassword.elementsEqual(confirmPassword) {
            isMatchingPasswords = false
            return false
        }
        return true
    }
    
    @MainActor
    func checkCurrentPassword() -> Bool {
        return true
    }
}
