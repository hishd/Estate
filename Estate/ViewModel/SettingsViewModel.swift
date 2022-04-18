//
//  SettingsViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-12.
//

import Foundation

class SettingsViewModel: ObservableObject, UserUpdateService {
    @Published var mobileNo: String = ""
    @Published var locationLat: Double = 0
    @Published var locationLon: Double = 0
    
    func fetchLocation() {
        
    }
}

extension SettingsViewModel {
    // MARK: Concrete methods
    func updateUser(mobileNo: String, locationLat: Double, locationLon: Double) {
        
    }
    
    func updatePassword(current: String, new: String) {
        
    }
}
