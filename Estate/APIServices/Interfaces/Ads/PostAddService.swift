//
//  CreateAddService.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-29.
//

import UIKit

protocol PostAddService {
    func postNewAdd(of content: NewAddContent)
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
