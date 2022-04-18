//
//  MyAdsService.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-19.
//

import Foundation
import UIKit


protocol MyAdsService {
    func fetchMyAds()
    func removeAdd(addId: String)
    func updateAdd(of addItem: AddItem)
    func createNewAdd(of content: NewAddContent)
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
