//
//  PostAddView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-27.
//

import SwiftUI

struct PostAddView: View {
    @ObservedObject var viewModel = PostAddViewModel()
    let isPostAddOpen: Bool
    var body: some View {
        VStack {
            Text("Add Information")
                .font(Font.custom("gilroy-bold", size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ImageContainerView(addItem: $viewModel.addItem)
                .padding(.top, 32)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct ImageContainerView: View {
    
    @Binding var addItem: NewAddItem
    
    var body: some View {
        HStack {
            VStack {
                ImagePlaceholderItem(image: addItem.deedImage)
                
                Text("Deed Image")
                    .foregroundColor(AppColor.colorDark)
                    .font(Font.custom("gilroy-regular", size: 13))
                    .padding(.top, 5)
            }
            
            VStack {
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if addItem.addImages.count <= 5 {
                                ImagePlaceholderItem()
                            }
                            ForEach(addItem.addImages, id: \.self) { image in
                                ImagePlaceholderItem(image: image)
                            }
                        }
                    }
                }
                .padding(8)
                .frame(width: .infinity, height: 100)
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(AppColor.colorGray, lineWidth: 1)
                    )
                
                Text("Property Images (up to 5 images)")
                    .foregroundColor(AppColor.colorDark)
                    .font(Font.custom("gilroy-regular", size: 13))
                    .padding(.top, 5)
            }
            .padding(.leading, 10)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ImagePlaceholderItem: View {
    @State var image: UIImage?
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Button {
                    
                } label: {
                    VStack {
                        Image("add")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text("Add Image")
                            .foregroundColor(AppColor.colorDark)
                            .font(Font.custom("gilroy-regular", size: 11))
                            .padding(.top, 3)
                    }
                }
            }
        }
        .padding(image == nil ? 10 : 0)
        .frame(width: 80, height: 80)
        .background(AppColor.colorLightGray)
        .cornerRadius(10)
        .onLongPressGesture {
            
        }
    }
}

struct PostAddView_Previews: PreviewProvider {
    @State static var isPostAddOpen = false
    static var previews: some View {
        PostAddView(isPostAddOpen: self.isPostAddOpen)
    }
}


