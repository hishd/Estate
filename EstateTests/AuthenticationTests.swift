//
//  AuthenticationTests.swift
//  EstateTests
//
//  Created by Hishara Dilshan on 2022-05-16.
//

import Foundation
import XCTest
@testable import Estate

class Authenticationtests: XCTestCase {
    
    func testLogin() async {
        do {
            let result = try await FirebaseOperations.shared.signInAsync(emailAddress: "hishara@gmail.com", password: "idmcc3")
            XCTAssertTrue(result)
        } catch {
            XCTFail("Login Failed with credentials")
        }
    }
    
    func testRegistration() async {
        do {
            let user = User(nicNo: "963070080V",
                            password: "idmcc3",
                            name: "Hishara Dilshan",
                            mobileNo: "0711116601",
                            emailAddress: "hisharadilshan2@gmail.com",
                            dob: .now,
                            gender: "Male",
                            locationLat: 0.0987,
                            locationLon: 1.9765)
            let result = try await FirebaseOperations.shared.registerUserAsync(user: user)
            XCTAssertTrue(result)
        } catch {
            debugPrint(error)
            XCTFail("Registration Failed with input data")
        }
    }
}
