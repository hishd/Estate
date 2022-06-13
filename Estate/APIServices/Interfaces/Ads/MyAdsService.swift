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
}
