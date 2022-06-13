//
//  WebService.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-06-13.
//

import Foundation
import UIKit

protocol WebService : UserService, AdsService, AuthenticationService {
    
}

// MARK: User Update Service
protocol UserService {
    func getUserDataAsync(by email: String) async throws -> User?
    func updateUser(mobileNo: String, locationLat: Double, locationLon: Double) async throws -> Bool
    func updatePassword(of email: String, of current: String, with new: String) async throws -> Bool
}

// MARK: Ads Service
protocol AdsService {
    func fetchAllAds() async throws -> [AddItem]
    func filterAds(by district: String) async throws -> [AddItem]
    func filterAds(minPrice: Double, maxPrice: Double, maxRadius: Int, isLand: Bool) async throws -> [AddItem]
    
    func fetchMyAds(by email: String) async throws -> [AddItem]
    func removeAdd(by addId: String) async throws -> Bool
    func updateAdd(by addId: String, with addItem: AddItem) async throws -> Bool
    
    func postNewAdd(of content: NewAddContent) async throws -> Bool
}

struct NewAddContent {
    var deedImage: UIImage
    var addImages: [UIImage]
    var price: Double
    var landSize: Double
    var district: String
    var town: String
    var locationLat: Double
    var locationLon: Double
    var isLand: Bool
    var information: String
    var contactNo: String
    //Users email address
    var createdUser: String
    var addCaption: String {
        if isLand {
            return String(format: "Perch %.0f land for sale", landSize)
        } else {
            return String(format: "House for sale in %@", town)
        }
    }
}

// MARK: Authntication Service
protocol AuthenticationService {
    var isSignedIn: Bool { get }
    func performSignIn(emailAddress: String, password: String) async throws -> Bool
    func performRegistration(user: User) async throws -> Bool
    func performSignOut() throws
}
