//
//  EstateApp.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-29.
//

import SwiftUI
import Firebase

@main
struct EstateApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
