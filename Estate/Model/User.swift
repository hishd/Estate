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
    
    func signIn(emailAddress: String, password: String) async throws -> Bool {
        if FirebaseOperations.shared.isSignedIn {
            return true
        } else {
            return try await FirebaseOperations.shared.signInAsync(emailAddress: emailAddress, password: password)
        }
    }
    
    func signUp(user: User) async throws -> Bool {
        return try await FirebaseOperations.shared.registerUserAsync(user: user)
    }
}
