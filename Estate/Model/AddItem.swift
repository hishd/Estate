//
//  AddItem.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-06.
//

import Foundation
import UIKit

class AddItem {
    var addCaption: String
    var deedImageUrl: String?
    var addImageUrls: [String]?
    var price: String
    var landSize: String
    var district: String
    var town: String
    var locationLat: Double
    var locationLon: Double
    var isLand: Bool
    var information: String
    var contactNo: String
    //Users email address
    var createdUser: String
    
    var allImageUrls: [String] {
        var allImages: [String] = []
        if let addImages = addImageUrls {
            allImages.append(contentsOf: addImages)
        }
        if let deedImage = deedImageUrl {
            allImages.append(deedImage)
        }
        return allImages
    }
    
    init(addCaption: String, deedImageUrl: String?, addImageUrls: [String]?, price: Double, landSize: Double, district: String, town: String, locationLat: Double, locationLon: Double, isLand: Bool, information: String, createdUser: String, contactNo: String) {
        self.addCaption = addCaption
        self.deedImageUrl = deedImageUrl
        self.addImageUrls = addImageUrls
        self.price = String(price)
        self.landSize = String(landSize)
        self.district = district
        self.town = town
        self.locationLat = locationLat
        self.locationLon = locationLon
        self.isLand = isLand
        self.information = information
        self.createdUser = createdUser
        self.contactNo = contactNo
    }
    
    convenience init() {
        self.init(addCaption: "", deedImageUrl: nil, addImageUrls: nil, price: 0, landSize: 0, district: "", town: "", locationLat: 0, locationLon: 0, isLand: true, information: "", createdUser: "", contactNo: "")
    }
}

extension AddItem {
    static var sample: AddItem {
        AddItem(
            addCaption: "Add Caption",
            deedImageUrl: "https://picsum.photos/200",
            addImageUrls: ["https://picsum.photos/id/237/200"],
            price: 500410, landSize: 50,
            district: "District",
            town: "Town Name",
            locationLat: 0, locationLon: 0,
            isLand: true,
            information: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec turpis vel libero laoreet congue eu vitae risus. Donec ornare tellus nec lorem ullamcorper rhoncus.",
            createdUser: "sample@email.com",
            contactNo: "+94716667767"
        )
    }
}

extension AddItem: AdsService {
    func fetchAllAds() async throws -> [AddItem] {
        return try await FirebaseService.shared.fetchAllAds()
    }
    
    func filterAds(by district: String) async throws -> [AddItem] {
        return try await FirebaseService.shared.filterAds(by: district)
    }
    
    func filterAds(minPrice: Double, maxPrice: Double, maxRadius: Int, isLand: Bool) async throws -> [AddItem] {
        return try await FirebaseService.shared.filterAds(minPrice: minPrice, maxPrice: maxPrice, maxRadius: maxRadius, isLand: isLand)
    }
    
    func fetchMyAds(by email: String) async throws -> [AddItem] {
        return try await FirebaseService.shared.fetchMyAds(by: email)
    }
    
    func removeAdd(by addId: String) async throws -> Bool {
        return try await FirebaseService.shared.removeAdd(by: addId)
    }
    
    func updateAdd(by addId: String, with addItem: AddItem) async throws -> Bool {
        return try await FirebaseService.shared.updateAdd(by: addId, with: addItem)
    }
    
    func postNewAdd(of content: NewAddContent) async throws -> Bool {
        return try await FirebaseService.shared.postNewAdd(of: content)
    }
}
