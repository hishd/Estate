//
//  AddInformationView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-12.
//

import SwiftUI

struct AddInformationView: View {
    let addItem: AddItem
    @StateObject var viewModel = AddInformationViewModel()
    var body: some View {
        VStack {
            // TODO: - Remove the sample add images after firebase integration
            AddImageSlider(addImages: sampleAddImages)
                .frame(width: .infinity, height: 250)
            
            Text(addItem.addCaption)
                .font(Font.custom("gilroy-extrabold", size: 22))
                .foregroundColor(AppColor.colorDark)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top, 20)
            
            AddInformationContainer(addItem: addItem)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            viewModel.addItem = self.addItem
        }
    }
}

struct AddInformationContainer: View {
    let addItem: AddItem
    var body: some View {
        VStack {
            //: Location & Contact Information Container
            HStack(spacing: 20) {
                //: Location Container
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 15) {
                        Image("location-pin")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text(addItem.town)
                            .font(Font.custom("gilroy-semibold", size: 18))
                            .foregroundColor(AppColor.colorDark)
                        
                    }
                    
                    HStack(spacing: 15) {
                        Image("call")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text(addItem.contactNo)
                            .font(Font.custom("gilroy-semibold", size: 18))
                            .foregroundColor(AppColor.colorDark)
                        
                    }
                }
                
                //: Contact Number Container
                VStack {
                    Button {
                        
                    } label: {
                        Text("View")
                            .foregroundColor(AppColor.colorPrimary)
                            .font(Font.custom("gilroy-semibold", size: 15))
                            .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
                    }
                    .background(AppColor.colorLightGray)
                    .cornerRadius(20)
                    .padding(.top, 5)
                    
                    Button {
                        
                    } label: {
                        Text("Call")
                            .foregroundColor(AppColor.colorPrimary)
                            .font(Font.custom("gilroy-semibold", size: 15))
                            .padding(EdgeInsets(top: 10, leading: 28, bottom: 10, trailing: 28))
                    }
                    .background(AppColor.colorLightGray)
                    .cornerRadius(20)
                    .padding(.bottom, 6)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 10)
            
            //: Price and Size of Land Container
            HStack(alignment: .bottom, spacing: 20) {
                HStack(alignment: .bottom,spacing: 15) {
                    Image("lkr")
                        .resizable()
                        .frame(width: 25, height: 16)
                    Text(addItem.price)
                        .font(Font.custom("gilroy-semibold", size: 18))
                        .foregroundColor(AppColor.colorDark)
                    
                }
                
                HStack(alignment: .bottom,spacing: 15) {
                    Image("size")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("\(addItem.landSize) Perches")
                        .font(Font.custom("gilroy-semibold", size: 18))
                        .foregroundColor(AppColor.colorDark)
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            //: Add information Container
            VStack(alignment: .leading) {
                Text("Information")
                    .font(Font.custom("gilroy-extrabold", size: 20))
                    .foregroundColor(AppColor.colorDark)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                ScrollView(.vertical, showsIndicators: false) {
                    Text(addItem.information)
                        .padding(.top, 5)
                        .font(Font.custom("gilroy-regular", size: 18))
                        .foregroundColor(AppColor.colorDark)
                        .lineSpacing(5)
                }
            }
        }
    }
}

struct AddInformationView_Previews: PreviewProvider {
    static var previews: some View {
        AddInformationView(addItem: AddItem.sample)
    }
}
