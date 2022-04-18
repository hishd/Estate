//
//  FetchAdsService.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-19.
//

import Foundation

protocol FetchAdsService {
    func fetchAllAds()
    func filterAdsOnDistrict()
    func filterAds(minPrice: Double, maxPrice: Double, maxRadius: Int, isLand: Bool)
}
