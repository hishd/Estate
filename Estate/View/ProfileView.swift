//
//  ProfileView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-11.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            ProfileHeaderView()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct ProfileHeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Text("My Profile")
                    .font(Font.custom("gilroy-semibold", size: 26))
                .foregroundColor(AppColor.colorPrimary)
                
                Spacer()
            }
    
            HStack {
                Text("My Ads")
                    .font(Font.custom("gilroy-medium", size: 18))
                    .foregroundColor(AppColor.colorDark)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("New Add")
                        .foregroundColor(AppColor.colorPrimary)
                        .font(Font.custom("gilroy-semibold", size: 15))
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                }
                .background(AppColor.colorLightGray)
                .cornerRadius(20)
                .padding(.leading, 30)
            }
            .padding(.top, 10)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
