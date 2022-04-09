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
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                }
                VStack {
                    HStack {
                        Image("location-pin")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .padding(.trailing, 5)
                        Text(addItem.town)
                            .foregroundColor(Color("color-dark"))
                            .font(Font.custom("gilroy-bold", size: 20))
                        Spacer()
                    }
                    HStack {
                        Image("lkr")
                            .resizable()
                            .frame(width: 25, height: 16, alignment: .center)
                            .padding(.trailing, 5)
                        Text(addItem.price)
                            .foregroundColor(Color("color-dark"))
                            .font(Font.custom("gilroy-bold", size: 20))
                        Spacer()
                    }
                }
                .padding()
            }
            HStack {
                Spacer()
                Image(addItem.isLand ? "land" : "house")
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .padding()
        }
        .background(Color("color-lightgray"))
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(addItem: AddItem.sample)
    }
}
