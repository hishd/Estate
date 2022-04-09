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
    @Published var selectedDistrict: String = "Colombo"
    
    //Fetching all ads and present it on Home View
    func getAllAds() {
        for _ in 0...20 {
            ads.append(HomeViewAddItem(addItem: AddItem.sample))
        }
    }
}

struct HomeViewAddItem: Identifiable {
    var id = UUID()
    let addItem: AddItem
}
