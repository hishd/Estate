//
//  User.swift
//  NIBM Broker
//
//  Created by Hishara Dilshan on 2022-03-27.
//

import Foundation
import FirebaseAuth

enum SignInError: Error {
    case operationError
    case noUserFound
}

class User {
    var nicNo: String
    var password: String
    var name: String
    var mobileNo: String
    var emailAddress: String
    var dobDay: Int
    var dobMonth: Int
    var dobYear: Int
    var gender: String
    var locationLat: Double
    var locationLon: Double
    
    init(nicNo: String, password: String, name: String, mobileNo: String, emailAddress: String, dobDay: Int, dobMonth: Int, dobYear: Int, gender: String, locationLat: Double, locationLon: Double) {
        self.nicNo = nicNo
        self.password = password
        self.name = name
        self.mobileNo = mobileNo
        self.emailAddress = emailAddress
        self.dobDay = dobDay
        self.dobMonth = dobMonth
        self.dobYear = dobYear
        self.gender = gender
        self.locationLat = locationLat
        self.locationLon = locationLon
    }
    
    convenience init(emailAddress: String, password: String) {
        self.init(nicNo: "", password: password, name: "", mobileNo: "", emailAddress: emailAddress, dobDay: 0, dobMonth: 0, dobYear: 0, gender: "", locationLat: 0, locationLon: 0)
    }
    
    var isSignedIn: Bool {
        let auth = Auth.auth()
        return auth.currentUser != nil
    }
    
    func signInAsync(emailAddress: String, password: String) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            let auth = Auth.auth()
            auth.signIn(withEmail: emailAddress, password: password) { [weak self] result, error in
                guard result != nil, error == nil else {
                    continuation.resume(throwing: SignInError.operationError)
                    return
                }
                
                continuation.resume(returning: true)
            }
        }
    }
}
