//
//  User.swift
//  NIBM Broker
//
//  Created by Hishara Dilshan on 2022-03-27.
//

import Foundation

enum SignInError: Error {
    case operationError
    case noUserFound
}

class User: Codable {
    var nicNo: String
    var password: String
    var name: String
    var mobileNo: String
    var emailAddress: String
    var dob: Date
    var gender: String
    var locationLat: Double
    var locationLon: Double
        
    init(nicNo: String, password: String, name: String, mobileNo: String, emailAddress: String, dob: Date, gender: String, locationLat: Double, locationLon: Double) {
        self.nicNo = nicNo
        self.password = password
        self.name = name
        self.mobileNo = mobileNo
        self.emailAddress = emailAddress
        self.dob = dob
        self.gender = gender
        self.locationLat = locationLat
        self.locationLon = locationLon
    }
    
    convenience init(emailAddress: String, password: String) {
        self.init(nicNo: "", password: password, name: "", mobileNo: "", emailAddress: emailAddress, dob: Date(), gender: "", locationLat: 0, locationLon: 0)
    }
    
    convenience init() {
        self.init(nicNo: "", password: "", name: "", mobileNo: "", emailAddress: "", dob: Date(), gender: "", locationLat: 0, locationLon: 0)
    }
    
    convenience init(nicNo: String, name: String, mobileNo: String, emailAddress: String, gender: String, locationLat: Double, locationLon: Double) {
        self.init(nicNo: nicNo, password: "", name: name, mobileNo: mobileNo, emailAddress: emailAddress, dob: Date(), gender: gender, locationLat: locationLat, locationLon: locationLon)
    }
    
}

extension User: UserService, AuthenticationService {
    
    var isSignedIn: Bool {
        return APIServiceFactory.getApiService().isSignedIn
    }
    
    func performSignIn(emailAddress: String, password: String) async throws -> Bool {
        if isSignedIn {
            return true
        } else {
            return try await APIServiceFactory.getApiService().performSignIn(emailAddress: emailAddress, password: password)
        }
    }
    
    func performRegistration(user: User) async throws -> Bool {
        return try await APIServiceFactory.getApiService().performRegistration(user: user)
    }
    
    func getUserDataAsync(by email: String) async throws -> User? {
        return try await APIServiceFactory.getApiService().getUserDataAsync(by: emailAddress)
    }
    
    func updateUser(mobileNo: String, locationLat: Double, locationLon: Double) async throws -> Bool {
        return try await APIServiceFactory.getApiService().updateUser(mobileNo: mobileNo, locationLat: locationLat, locationLon: locationLon)
    }
    
    func updatePassword(of email: String, of current: String, with new: String) async throws -> Bool {
        return try await APIServiceFactory.getApiService().updatePassword(of: email, of: current, with: new)
    }
    
    func performSignOut() throws {
        try APIServiceFactory.getApiService().performSignOut()
    }
}
