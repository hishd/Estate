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
        ZStack {
            VStack {
                TopView(viewModel: viewModel)
                AddList(viewModel: viewModel)
            }
            .padding()
            .onAppear {
                viewModel.getAllAds()
//                viewModel.isGuestUser = false
            }
            .blur(radius: viewModel.userFilterVisible ? 3 : 0)
            if viewModel.userFilterVisible {
                BottomFilterView(viewModel: viewModel)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

struct AddList: View {
    @ObservedObject var viewModel: HomeViewModel
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns, spacing: 20) {
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
    @ObservedObject var viewModel: HomeViewModel
    let districts = Array(DistrictNames.allCases)
    var body: some View {
        VStack {
            HStack {
                Text("Ads in \(viewModel.selectedDistrict.rawValue)")
                    .font(Font.custom("gilroy-semibold", size: 26))
                .foregroundColor(AppColor.colorPrimary)
                Spacer()
            }
            HStack {
                Text(viewModel.isGuestUser ? "Select District" : "Filter Ads")
                    .font(Font.custom("gilroy-medium", size: 18))
                    .foregroundColor(AppColor.colorDark)
                Spacer()
                //If Guest user Show only the District Filter View
                if viewModel.isGuestUser {
                    ZStack {
                        Picker("", selection: $viewModel.selectedDistrict) {
                            ForEach(districts, id: \.rawValue) {
                                Text($0.rawValue)
                                    .tag($0)
                                    .foregroundColor(AppColor.colorPrimary)
                            }
                        }
                        .padding(EdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 10))
                    }
                    .background(AppColor.colorLightGray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                //Else show the Logged in user multi filter view
                else {
                    Button {
                        withAnimation {
                            viewModel.userFilterVisible.toggle()
                        }
                    } label: {
                        Text(viewModel.isGuestUser ? "Select" : "Filter")
                            .foregroundColor(AppColor.colorPrimary)
                            .font(Font.custom("gilroy-semibold", size: 15))
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    }
                    .background(AppColor.colorLightGray)
                    .cornerRadius(20)
                    .padding(.leading, 30)
                }
            }
            .padding(.top, 10)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .top)
    }
}

struct BottomFilterView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        GeometryReader { geometry in
            BottomView(maxHeight: geometry.size.height * 0.7) {
                VStack {
                    HStack {
                        Text("Filter Ads")
                            .font(Font.custom("gilroy-semibold", size: 22))
                            .foregroundColor(AppColor.colorDark)
                        Spacer()
                        Button {
                            withAnimation {
                                viewModel.userFilterVisible.toggle()
                            }
                        } label: {
                            Text("Done")
                                .foregroundColor(AppColor.colorPrimary)
                                .font(Font.custom("gilroy-semibold", size: 15))
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        }
                        .background(AppColor.colorLightGray)
                        .cornerRadius(20)
                    }
                    
                    HStack {
                        Text("Price Range")
                            .font(Font.custom("gilroy-regular", size: 18))
                            .foregroundColor(AppColor.colorGray)
                            .padding(.trailing, 10)
                        Spacer()
                        TextField("Min Price", text: $viewModel.minPrice)
                            .keyboardType(.decimalPad)
                            .frame(width: 110, height: .infinity, alignment: .trailing)
                        TextField("Max Price", text: $viewModel.maxPrice)
                            .keyboardType(.decimalPad)
                            .frame(width: 110, height: .infinity, alignment: .trailing)
                            .padding(.leading, 10)
                    }
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, 20)
                    
                    HStack(alignment: .top) {
                        Text("Search Radius")
                            .font(Font.custom("gilroy-regular", size: 18))
                            .foregroundColor(AppColor.colorGray)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 15))
                        VStack {
                            Slider(value: $viewModel.searchRadius, in: 0...100)
                                .tint(AppColor.colorPrimary)
                            Text(String(format: "%.0f KM", viewModel.searchRadius))
                                .font(Font.custom("gilroy-medium", size: 18))
                                .foregroundColor(AppColor.colorGray)
                        }
                    }
                    .padding(.top, 10)
                    
                    HStack {
                        Text("Property Type : \(viewModel.filterLands ? "Land" : "House")")
                            .font(Font.custom("gilroy-regular", size: 18))
                            .foregroundColor(AppColor.colorGray)
                        Spacer()
                        Toggle("", isOn: $viewModel.filterLands)
                            .tint(AppColor.colorPrimary)
                    }
                    .padding(.top, 10)
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
