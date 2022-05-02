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
            
            ScrollView {
                AddInformationInputView(viewModel: viewModel)
            }
            .padding(.top, 20)
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
                        withAnimation {
                            if !isDeedImage {
                                viewModel.removeSelectedAddImage(at: index!)
                            } else {
                                self.image = nil
                                viewModel.addItem.deedImage = nil
                            }
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

struct AddInformationInputView: View {
    @ObservedObject var viewModel: PostAddViewModel
    let districts = Array(DistrictNames.allCases)
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HStack(spacing: 20) {
                    VStack {
                        HStack {
                            Text("Price")
                            Spacer()
                        }
                        TextField("Enter Price", text: $viewModel.price)
                            .onChange(of: viewModel.price) { newValue in
                                viewModel.isValidPrice = FieldValidator.shared.isValidPrice(of: newValue)
                            }
                            .keyboardType(.decimalPad)
                        ErrorPlaceholder(isValid: $viewModel.isValidPrice, message: ValidationCaptions.invalidPrice.rawValue)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VStack {
                        HStack {
                            Text("Land Size")
                            Spacer()
                        }
                        TextField("Enter Size", text: $viewModel.landSize)
                            .onChange(of: viewModel.landSize) { newValue in
                                viewModel.isValidLandSize = FieldValidator.shared.isValidLandSize(of: newValue)
                            }
                            .keyboardType(.decimalPad)
                        ErrorPlaceholder(isValid: $viewModel.isValidLandSize, message: ValidationCaptions.invalidLandSize.rawValue)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                
                HStack(spacing: 20) {
                    VStack {
                        HStack {
                            Text("District")
                            Spacer()
                        }
                        
                        ZStack {
                            Picker("", selection: $viewModel.district) {
                                ForEach(districts, id: \.rawValue) {
                                    Text($0.rawValue)
                                        .tag($0)
                                        .foregroundColor(AppColor.colorPrimary)
                                }
                            }
                            .padding(EdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 10))
                            .frame(maxWidth: .infinity)
                        }
                        .background(AppColor.colorLightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VStack {
                        HStack {
                            Text("Town")
                            Spacer()
                        }
                        TextField("Enter Town", text: $viewModel.town)
                            .onChange(of: viewModel.town) { newValue in
                                viewModel.isValidTown = FieldValidator.shared.isValidTownName(of: newValue)
                            }
                        ErrorPlaceholder(isValid: $viewModel.isValidTown, message: ValidationCaptions.invalidTown.rawValue)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding(.top, 10)
                
                VStack {
                    HStack {
                        Text("Location")
                        Spacer()
                    }
                    HStack {
                        TextField("Press select to add", text: $viewModel.location)
                            .disabled(true)
                        Button {
                            
                        } label: {
                            Text("Select")
                                .foregroundColor(AppColor.colorPrimary)
                                .font(Font.custom("gilroy-semibold", size: 18))
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        }
                        .background(AppColor.colorLightGray)
                        .cornerRadius(20)
                        .padding(.leading, 30)
                    }
                    
                    ErrorPlaceholder(isValid: $viewModel.isValidLocation, message: ValidationCaptions.invalidLocation.rawValue)
                }
                .padding(.top, 10)
                
                HStack {
                    Text("Property Type : \(viewModel.isLand ? "Land" : "House")")
                        .font(Font.custom("gilroy-regular", size: 16))
                        .foregroundColor(AppColor.colorDark)
                    Spacer()
                    Toggle("", isOn: $viewModel.isLand)
                        .tint(AppColor.colorPrimary)
                        .padding(.trailing, 5)
                }
                .padding(.top, 10)
                
                VStack {
                    HStack {
                        Text("Information")
                        Spacer()
                    }
                    TextEditor(text: $viewModel.information)
                        .onChange(of: viewModel.information) { newValue in
                            viewModel.isValidInformation = FieldValidator.shared.isValidAddInfo(of: newValue)
                        }
                        .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary).opacity(0.5))
                        .frame(height: 100)
                    ErrorPlaceholder(isValid: $viewModel.isValidInformation, message: ValidationCaptions.invalidInformation.rawValue)
                }
                .padding(.top, 10)
                
                Button {
//                    viewModel.postNewAdd(of: <#T##NewAddContent#>)
                } label: {
                    Text("Post Add")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30))
                        .font(Font.custom("gilroy-semibold", size: 18))
                }
                .background(AppColor.colorPrimary)
                .cornerRadius(25)
                .padding([.top, .bottom], 20)
                
            }
            .font(Font.custom("gilroy-regular", size: 18))
            .textFieldStyle(.roundedBorder)
        }
    }
}

struct PostAddView_Previews: PreviewProvider {
    @State static var isPostAddOpen = false
    static var previews: some View {
        PostAddView(isPostAddOpen: self.isPostAddOpen)
    }
}


