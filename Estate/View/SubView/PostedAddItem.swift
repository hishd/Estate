//
//  PostedAddItem.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-12.
//

import SwiftUI

struct PostedAddItem: View {
    let addItem: AddItem
    var body: some View {
        HStack {
            if let imageUrl = addItem.addImageUrls?[0] {
                ZStack {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 140)
                            .clipped()
                    } placeholder: {
                        ProgressView("Loading")
                            .padding()
                    }
                }
            } else {
                Image("sample-land")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 140)
                    .clipped()
            }
            
            VStack(alignment: .leading) {
                Text(addItem.addCaption)
                    .lineLimit(1)
                    .font(Font.custom("gilroy-semibold", size: 20))
                    .foregroundColor(AppColor.colorDark)
                
                HStack(spacing: 10) {
                    Image("location-pin")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(addItem.town)
                        .lineLimit(1)
                        .font(Font.custom("gilroy-semibold", size: 16))
                        .foregroundColor(AppColor.colorDark)
                        .padding(.leading, 8)
                }
                .padding(.top, 6)
                
                HStack(alignment: .bottom,spacing: 15) {
                    Image("lkr")
                        .resizable()
                        .frame(width: 24, height: 14)
                    Text(addItem.price.extractInMillions())
                        .lineLimit(1)
                        .font(Font.custom("gilroy-semibold", size: 16))
                        .foregroundColor(AppColor.colorDark)
                    
                }
                .padding(.top, 3)
                
                HStack(alignment: .bottom,spacing: 15) {
                    Image("size")
                        .resizable()
                        .frame(width: 18, height: 18)
                    Text("\(addItem.landSize) Perches")
                        .lineLimit(1)
                        .font(Font.custom("gilroy-semibold", size: 16))
                        .foregroundColor(AppColor.colorDark)
                        .padding(.leading, 5)
                }
                .padding(.top, 3)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            Spacer()
        }
        .background(AppColor.colorLightGray)
        .cornerRadius(10)
        .frame(height: 150)
    }
}

struct PostedAddItem_Previews: PreviewProvider {
    static var previews: some View {
        PostedAddItem(addItem: AddItem.sample)
            .previewLayout(.sizeThatFits)
    }
}
