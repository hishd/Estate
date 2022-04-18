//
//  StartView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-19.
//

import Foundation
import SwiftUI

struct StartView: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        if settings.loggedIn {
            return AnyView(HomeView())
        } else {
            return AnyView(SignInView())
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(UserSettings())
    }
}
