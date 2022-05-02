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
            
            ImageContainerView(addItem: $viewModel.addItem, viewModel: viewModel)
                .padding(.top, 32)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct ImageContainerView: View {
    @Binding var addItem: NewAddItem
    @ObservedObject var viewModel: PostAddViewModel
    
    var body: some View {
        HStack {
            VStack {
                ImagePlaceholderItem(viewModel: viewModel,isDeedImage: true, image: addItem.deedImage)
                    .padding(.top, 10)
                
                Text("Deed Image")
                    .foregroundColor(AppColor.colorDark)
                    .font(Font.custom("gilroy-regular", size: 13))
                    .padding(.top, 13)
            }
            
            VStack {
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if addItem.addImages.count <= 5 {
                                ImagePlaceholderItem(viewModel: viewModel)
                            }
                            ForEach(Array(addItem.addImages.enumerated()), id: \.element) { index, imageItem in
                                ImagePlaceholderItem(viewModel: viewModel
                                                     , index: index,
                                                     image: imageItem)
                            }
                        }
                    }
                }
                .padding(8)
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
    @ObservedObject var viewModel: PostAddViewModel
    var index: Int?
    var isDeedImage = false
    @State var image: UIImage?
    
    var body: some View {
        VStack {
            if let image = image {
                ZStack(alignment: .top) {
                    Image(uiImage: image)
                        .resizable()
                        
                    Button {
                        if !isDeedImage {
                            viewModel.removeSelectedAddImage(at: index!)
                        } else {
                            self.image = nil
                            viewModel.addItem.deedImage = nil
                        }
                    } label: {
                        Image("btn-remove")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding([.top, .trailing], 3)
                }
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
    }
}

struct PostAddView_Previews: PreviewProvider {
    @State static var isPostAddOpen = false
    static var previews: some View {
        PostAddView(isPostAddOpen: self.isPostAddOpen)
    }
}


