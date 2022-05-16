//
//  UserSettings.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-19.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var loggedIn: Bool = false
    //Fetch the userdata using the UserDefaults
    var currentUser: User {
        User(nicNo: "000000000X", password: "", name: "Sample User", mobileNo: "0876667765", emailAddress: "user@yahoo.com", dob: Date(), gender: "Male", locationLat: 0, locationLon: 0)
    }
}
