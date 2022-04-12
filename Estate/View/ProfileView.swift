//
//  ProfileView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-11.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        VStack {
            ProfileHeaderView()
            AllAdsContainer(viewModel: viewModel)
        }
        .onAppear {
            viewModel.fetchAllPostedAds()
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

struct AllAdsContainer: View {
    @ObservedObject var viewModel: ProfileViewModel
    let columns: [GridItem] = [.init(.flexible())]
    var body: some View {
//: Changed to List Implementation since onDelete is not Supported on Grids
//        ScrollView(.vertical) {
//            LazyVGrid(columns: columns, spacing: 20) {
//                ForEach(viewModel.allPostedAds) { add in
//                    PostedAddItem(addItem: add.addItem)
//                }.onDelete { index in
//
//                }
//            }
//        }
//        .padding(.top, 20)
        List {
            ForEach(viewModel.allPostedAds) { add in
                PostedAddItem(addItem: add.addItem)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    .listRowSeparator(.hidden)
            }.onDelete { index in
                //: Action on Delete
            }
        }.listStyle(.plain)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
