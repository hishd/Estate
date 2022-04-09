//
//  HomeView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-09.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
        VStack {
            TopView(selectedDistrict: viewModel.selectedDistrict, isGuestUser: viewModel.isGuestUser)
            AddList(viewModel: viewModel)
        }
        .padding()
        .onAppear {
            viewModel.getAllAds()
        }
    }
}

struct AddList: View {
    @ObservedObject var viewModel: HomeViewModel
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns, spacing: 20) {
//                ForEach((0...10), id: \.self) {_ in
//                    AddItemView(addItem: AddItem.sample)
//                        .aspectRatio(2/3, contentMode: .fit)
//                }
                ForEach(viewModel.ads) { item in
                    AddItemView(addItem: item.addItem)
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .padding(.top, 20)
    }
}

struct TopView: View {
    @State var selectedDistrict: String
    @State var isGuestUser: Bool
    var body: some View {
        VStack {
            HStack {
                Text("Ads in \(selectedDistrict)")
                    .font(Font.custom("gilroy-semibold", size: 26))
                .foregroundColor(Color("color-primary"))
                Spacer()
            }
            HStack {
                Text(isGuestUser ? "Select District" : "Filter Ads")
                    .font(Font.custom("gilroy-medium", size: 18))
                    .foregroundColor(Color("color-dark"))
                Spacer()
                Button {
                    
                } label: {
                    Text(isGuestUser ? "Select" : "Filter")
                        .foregroundColor(Color("color-primary"))
                        .font(Font.custom("gilroy-semibold", size: 15))
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                }
                .background(Color("color-lightgray"))
                .cornerRadius(20)
                .padding(.leading, 30)
            }
            .padding(.top, 10)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
