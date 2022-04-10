//
//  OrderView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-11.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            SettingsHeaderView()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct SettingsHeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(Font.custom("gilroy-semibold", size: 26))
                .foregroundColor(AppColor.colorPrimary)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Sign out")
                        .foregroundColor(AppColor.colorPrimary)
                        .font(Font.custom("gilroy-semibold", size: 15))
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                }
                .background(AppColor.colorLightGray)
                .cornerRadius(20)
                .padding(.leading, 30)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
