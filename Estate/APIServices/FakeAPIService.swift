//
//  FakeAPIService.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-06-13.
//

import Foundation

class FakeAPIService: WebService {
    let shared = FakeAPIService()
    
    private init() {}
    
    func getUserDataAsync(by email: String) async throws -> User? {
        return User(nicNo: "", password: "", name: "", mobileNo: "", emailAddress: "", dob: Date(), gender: "", locationLat: 0, locationLon: 0)
    }
    
    func updateUser(mobileNo: String, locationLat: Double, locationLon: Double) async throws -> Bool {
        return true
    }
    
    func updatePassword(of email: String, of current: String, with new: String) async throws -> Bool {
        return true
    }
    
    func fetchAllAds() async throws -> [AddItem] {
        return []
    }
    
    func filterAds(by district: String) async throws -> [AddItem] {
        return []
    }
    
    func filterAds(minPrice: Double, maxPrice: Double, maxRadius: Int, isLand: Bool) async throws -> [AddItem] {
        return []
    }
    
    func fetchMyAds(by email: String) async throws -> [AddItem] {
        return []
    }
    
    func removeAdd(by addId: String) async throws -> Bool {
        return true
    }
    
    func updateAdd(by addId: String, with addItem: AddItem) async throws -> Bool {
        return true
    }
    
    func postNewAdd(of content: NewAddContent) async throws -> Bool {
        return true
    }
    
    func performSignIn(emailAddress: String, password: String) async throws -> Bool {
        return true
    }
    
    func performRegistration(user: User) async throws -> Bool {
        return true
    }
    
    func performSignOut() throws {
        
    }
}
