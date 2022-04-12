//
//  HomeViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-09.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var isGuestUser: Bool = true
    @Published var ads: [HomeViewAddItem] = []
    @Published var selectedDistrict: DistrictNames = .colombo
    
    //Bottom Filterview Properties
    @Published var userFilterVisible: Bool = false
    @Published var minPrice: String = ""
    @Published var maxPrice: String = ""
    @Published var searchRadius: Double = 0
    @Published var priceRangeMin: Double = 0
    @Published var priceRangeMax: Double = 0
    @Published var filterLands: Bool = true
    
    //Fetching all ads and present it on Home View
    func getAllAds() {
        ads.removeAll()
        for _ in 0...20 {
            ads.append(HomeViewAddItem(addItem: AddItem.sample))
        }
    }
}

struct HomeViewAddItem: Identifiable {
    var id = UUID()
    let addItem: AddItem
}
