//
//  AddImageSlider.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-12.
//

import SwiftUI

struct AddImageSlider: View {
    let addImages: [String]
    var body: some View {
        TabView {
            ForEach(addImages, id: \.self) { image in
                ImageSliderItem(imageUrl: image)
                    .padding(.top, 10)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

struct ImageSliderItem: View {
    let imageUrl: String
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: imageUrl), transaction: Transaction(animation: .spring())) { phase in
                switch phase {
                case .empty:
                    ProgressView("Loading")
                        .padding()
                case .success(let image):
                    image
                        .resizable()
                        .cornerRadius(15)
                        .transition(.scale)
                default:
                    Image(systemName: "exclamationmark.icloud")
                }
            }
        }
    }
}

struct AddImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        AddImageSlider(addImages: sampleAddImages)
            .previewDevice("iPhone 11")
            .background(AppColor.colorGray)
    }
}
