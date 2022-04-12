//
//  ProfileViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-12.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User = User()
    @Published var allPostedAds: [ProfileViewAddItem] = []
    
    func fetchAllPostedAds() {
        allPostedAds.removeAll()
        for _ in 0...20 {
            allPostedAds.append(ProfileViewAddItem(addItem: AddItem.sample))
        }
    }
}

struct ProfileViewAddItem: Identifiable {
    let id = UUID()
    let addItem: AddItem
}
