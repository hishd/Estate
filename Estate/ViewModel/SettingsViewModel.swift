//
//  SettingsViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-12.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var mobileNo: String = ""
    @Published var location: String = ""
    @Published var isPasswordOpen: Bool = false
    @Published var isSignOutShown: Bool = false
    
    // MARK: Input Field Validations
    @Published var isValidMobile: Bool = true
    @Published var isValidLocation: Bool = true
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    private var settingsEO: UserSettings?
    
    func setSettingsEO(eo: UserSettings) {
        self.settingsEO = eo
    }
    
    func fetchLocation() {
        
    }
    
    func signOut() {
        do {
            try User().performSignOut()
            UserSettings.shared.clearUserSession()
            settingsEO?.loggedIn = false
        } catch {
            self.isError = true
            self.errorMessage = "Error occurred during sign out."
        }
    }
}

extension SettingsViewModel {
    @MainActor
    func validateInput() -> Bool {
        if !FieldValidator.shared.isValidMobileNo(of: mobileNo) {
            isValidMobile = false
            return false
        }
        if location.isEmpty {
            isValidLocation = false
            return false
        }
        return true
    }
}

extension SettingsViewModel {
    // MARK: Concrete methods
    @MainActor
    func updateUser(mobileNo: String, locationLat: Double, locationLon: Double) {
        
    }
    
    @MainActor
    func updatePassword(current: String, new: String) {
        
    }
}
