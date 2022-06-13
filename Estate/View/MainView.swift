//
//  MainView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-11.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        if settings.loggedIn {
            MainTabView()
        } else {
            SignInView()
        }
    }
}

struct MainTabView: View {
    @State private var tabIndex = 0
    var body: some View {
        VStack {
            TabView(selection: $tabIndex) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(1)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(2)
                    .animation(.spring(), value: 1)
            }
        }
        .animation(.easeInOut, value: tabIndex)
        .transition(.slide)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserSettings.shared)
    }
}
