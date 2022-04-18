//
//  UserUpdateService.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-19.
//

import Foundation

protocol UserUpdateService {
    func updateUser(mobileNo: String, locationLat: Double, locationLon: Double)
    func updatePassword(current: String, new: String)
}
