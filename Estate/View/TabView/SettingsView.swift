//
//  OrderView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-11.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        NavigationView {
            VStack {
                SettingsHeaderView(viewModel: viewModel)
                UserInformationContainer(currentUser: settings.currentUser)
                    .padding(.top, 30)
                    .padding(.horizontal, 3)
                ScrollView(.vertical, showsIndicators: false) {
                    UserInformationTextFields(viewModel: viewModel)
                        .padding(.top, 40)
                        .padding(.horizontal, 5)
                    SettingsActionsContainer(viewModel: viewModel)
                        .padding(.top, 40)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .padding()
            
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.setSettingsEO(eo: settings)
        }
    }
}

struct SettingsHeaderView: View {
    @ObservedObject var viewModel: SettingsViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(Font.custom("gilroy-semibold", size: 26))
                .foregroundColor(AppColor.colorPrimary)
                
                Spacer()
                
                Button {
                    viewModel.isSignOutShown.toggle()
                } label: {
                    Text("Sign out")
                        .foregroundColor(AppColor.colorPrimary)
                        .font(Font.custom("gilroy-semibold", size: 15))
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                }
                .background(AppColor.colorLightGray)
                .cornerRadius(20)
                .padding(.leading, 30)
                .confirmationDialog("Sign out from EState?", isPresented: $viewModel.isSignOutShown, titleVisibility: .visible) {
                    Button("Sign Out", role: .destructive) {
                        viewModel.signOut()
                    }
                }
                .genericDialog(isShowing: $viewModel.isError) {
                    Text(viewModel.errorMessage)
                }
            }
        }
    }
}

struct UserInformationContainer: View {
    let currentUser: User?
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "person.circle.fill")
                .renderingMode(.template)
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(AppColor.colorPrimary)
            VStack(alignment: .leading, spacing: 6) {
                Text(currentUser?.name ?? "")
                    .font(Font.custom("gilroy-semibold", size: 22))
                    .foregroundColor(AppColor.colorDark)
                Text(currentUser?.emailAddress ?? "")
                    .font(Font.custom("gilroy-semibold", size: 18))
                    .foregroundColor(AppColor.colorGray)
                Text(currentUser?.nicNo ?? "")
                    .font(Font.custom("gilroy-semibold", size: 16))
                    .foregroundColor(AppColor.colorGray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct UserInformationTextFields: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                HStack {
                    Text("Mobile Number")
                    Spacer()
                }
                TextField("Enter Mobile no.", text: $viewModel.mobileNo)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.namePhonePad)
                    .onChange(of: viewModel.mobileNo) { newValue in
                        viewModel.isValidMobile = FieldValidator.shared.isValidMobileNo(of: newValue)
                    }
                TextFieldErrorPlaceholder(isValid: $viewModel.isValidMobile, message: ValidationCaptions.invalidMobileNo.rawValue)
            }
            
            VStack {
                HStack {
                    Text("Location")
                    Spacer()
                }
                HStack {
                    TextField("Press Fetch to load", text: $viewModel.location)
                        .disabled(true)
                    Button {
                        
                    } label: {
                        Text("Fetch")
                            .foregroundColor(AppColor.colorPrimary)
                            .font(Font.custom("gilroy-semibold", size: 18))
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    }
                    .background(AppColor.colorLightGray)
                    .cornerRadius(20)
                    .padding(.leading, 30)
                }
                
                TextFieldErrorPlaceholder(isValid: $viewModel.isValidLocation, message: ValidationCaptions.invalidLocation.rawValue)
            }
        }
        .font(Font.custom("gilroy-regular", size: 18))
        .textFieldStyle(.roundedBorder)
    }
}

struct SettingsActionsContainer: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Button {

            } label: {
                Text("Update")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .font(Font.custom("gilroy-semibold", size: 18))
            }
            .background(AppColor.colorPrimary)
            .cornerRadius(18)
            .padding([.top, .bottom], 10)
            

            NavigationLink(isActive: $viewModel.isPasswordOpen) {
                LazyView {
                    ChangePasswordView(isPasswordOpen: $viewModel.isPasswordOpen)
                }
            } label: {
                Button("Change Password") {
                    viewModel.isPasswordOpen.toggle()
                }
                .foregroundColor(AppColor.colorPrimary)
                .font(Font.custom("gilroy-semibold", size: 18))
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(UserSettings.shared)
    }
}
