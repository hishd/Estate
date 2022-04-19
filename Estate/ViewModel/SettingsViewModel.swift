//
//  SettingsViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-12.
//

import Foundation

class SettingsViewModel: ObservableObject, UserUpdateService {
    @Published var mobileNo: String = ""
    @Published var location: String = ""
    @Published var isPasswordOpen: Bool = false
    @Published var isSignOutShown: Bool = false
    
    // MARK: Input Field Validations
    @Published var isValidMobile: Bool = true
    @Published var isValidLocation: Bool = true
    
    func fetchLocation() {
        
    }
}

extension SettingsViewModel {
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
    func updateUser(mobileNo: String, locationLat: Double, locationLon: Double) {
        
    }
    
    func updatePassword(current: String, new: String) {
        
    }
}
