//
//  SignUpView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-31.
//

import SwiftUI
import CoreLocationUI

struct SignUpView: View {
    
    @Binding var showSignUpView: Bool
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                SignUpTopView()
                    .padding(.bottom, 30)
                SignUpInputView(viewModel: viewModel)
                    .alert("Signup Successful", isPresented: $viewModel.isShowingSuccess) {
                        Button("Ok") {
                            viewModel.isShowingSuccess = false
                            self.showSignUpView = false
                        }
                    } message: {
                        Text("User Signup successful. Please use your provided credentials on Signin.")
                    }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .alert("Sign up Error", isPresented: $viewModel.errorSignup) {
            
        } message: {
            Text(viewModel.errorSignupMessage)
        }
        .progressDialog(isShowing: $viewModel.isOnProgress, message: "Please wait...", progress: Progress(totalUnitCount: 0))

    }
}

struct SignUpTopView: View {
    var body: some View {
        VStack {
            Image("img-logo")
                .resizable()
                .frame(width: 240, height: 120, alignment: .center)
                .padding(.bottom, 10)
            Text("Sign Up")
                .foregroundColor(AppColor.colorPrimary)
                .font(Font.custom("gilroy-bold", size: 22))
        }
    }
}

struct SignUpInputView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("NIC Number")
                    Spacer()
                }
                TextField("Enter NIC Number", text: $viewModel.nicNo)
                    .onChange(of: viewModel.nicNo) { newValue in
                        viewModel.isValidNIC = FieldValidator.shared.isValidNIC(of: newValue)
                    }
                TextFieldErrorPlaceholder(isValid: $viewModel.isValidNIC, message: ValidationCaptions.invalidNIC.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Your Name")
                    Spacer()
                }
                TextField("Enter Name", text: $viewModel.name)
                    .textContentType(.name)
                    .onChange(of: viewModel.name) { newValue in
                        viewModel.isValidName = FieldValidator.shared.isValidPersonName(of: newValue)
                    }
                TextFieldErrorPlaceholder(isValid: $viewModel.isValidName,message: ValidationCaptions.invalidName.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
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
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Email Address")
                    Spacer()
                }
                TextField("Enter Email Address", text: $viewModel.emailAddress)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .onChange(of: viewModel.emailAddress) { newValue in
                        viewModel.isValidEmail = FieldValidator.shared.isValidEmailAddress(of: newValue)
                    }
                TextFieldErrorPlaceholder(isValid: $viewModel.isValidEmail, message: ValidationCaptions.invalidEmail.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                DatePicker(selection: $viewModel.dob , in: ...Date(), displayedComponents: .date) {
                    Text("Date of Birth")
                }
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            
            HStack {
                Text("Gender : \(viewModel.isMale ? "Male" : "Female")")
                Toggle("", isOn: $viewModel.isMale)
                    .tint(AppColor.colorPrimary)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            
            VStack {
                HStack {
                    Text("Location")
                    Spacer()
                }
                HStack {
                    TextField("Press button to load", text: $viewModel.currentLocation)
                        .disabled(true)
                    
                    LocationButton(.currentLocation) {
                        viewModel.loadCurrentLocation()
                    }
                    .labelStyle(.iconOnly)
                    .cornerRadius(8)
                    .tint(AppColor.colorPrimary)
                }
                
                TextFieldErrorPlaceholder(isValid: $viewModel.isValidLocation, message: ValidationCaptions.invalidLocation.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Password")
                    Spacer()
                }
                SecureField("Enter Password", text: $viewModel.password)
                    .onChange(of: viewModel.password) { newValue in
                        viewModel.isValidPassword = FieldValidator.shared.isValidPassword(of: viewModel.password)
                        viewModel.isMatchingPasswords = viewModel.password.elementsEqual(viewModel.confirmPassword)
                    }
                TextFieldErrorPlaceholder(isValid: $viewModel.isValidPassword, message: ValidationCaptions.invalidPassword.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            
            VStack {
                HStack {
                    Text("Confirm Password")
                    Spacer()
                }
                SecureField("Re-enter Password", text: $viewModel.confirmPassword)
                    .onChange(of: viewModel.confirmPassword) { newValue in
                        viewModel.isMatchingPasswords = viewModel.password.elementsEqual(viewModel.confirmPassword)
                    }
                TextFieldErrorPlaceholder(isValid: $viewModel.isMatchingPasswords, message: ValidationCaptions.passwordsNoMatch.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            
            Button {
                Task {
                    if await viewModel.registeruser() {
                        viewModel.isShowingSuccess = true
                    }
                }
            } label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .font(Font.custom("gilroy-semibold", size: 18))
            }
            .background(AppColor.colorPrimary)
            .cornerRadius(18)
            .padding([.top, .bottom], 10)
        }
        .font(Font.custom("gilroy-regular", size: 18))
        .textFieldStyle(.roundedBorder)
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static var showSignUpView = false
    static var previews: some View {
        SignUpView(showSignUpView: self.$showSignUpView)
            .previewDevice("iPhone 11")
    }
}
