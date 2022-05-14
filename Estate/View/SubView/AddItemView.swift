//
//  AddItemView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-08.
//

import SwiftUI

struct AddItemView: View {
    
    let addItem: AddItem
    
    var body: some View {
        ZStack {
            VStack {
                if let imageUrl = addItem.addImageUrls?[0] {
                    ZStack {
//                        AsyncImage(url: URL(string: imageUrl)) { image in
//                            image.resizable()
//                                .transition(.slide)
//                        } placeholder: {
//                            ProgressView()
//                        }
                        AsyncImage(url: URL(string: imageUrl), transaction: Transaction(animation: .spring())) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                .transition(.scale)
                            default:
                                Image(systemName: "exclamationmark.icloud")
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
                VStack {
                    HStack {
                        Image("location-pin")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .padding(.trailing, 5)
                        Text(addItem.town)
                            .foregroundColor(AppColor.colorDark)
                            .font(Font.custom("gilroy-bold", size: 18))
                        Spacer()
                    }
                    HStack {
                        Image("lkr")
                            .resizable()
                            .frame(width: 25, height: 16, alignment: .center)
                            .padding(.trailing, 5)
                        Text(addItem.price.extractInMillions())
                            .foregroundColor(AppColor.colorDark)
                            .font(Font.custom("gilroy-bold", size: 18))
                        Spacer()
                    }
                }
                .padding(10)
            }
            HStack {
                Spacer()
                Image(addItem.isLand ? "land" : "house")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .padding(5)
                    .background(Color.white)
                    .clipShape(Circle())
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .padding([.top, .trailing], 8)
        }
        .background(AppColor.colorLightGray)
        .cornerRadius(10)
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(addItem: AddItem.sample)
    }
}
