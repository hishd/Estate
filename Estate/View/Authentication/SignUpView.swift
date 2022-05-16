//
//  SignUpView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-31.
//

import SwiftUI
import CoreLocationUI

struct SignUpView: View {
    
    @State var isShowingSuccess = false
    @Binding var showSignUpView: Bool
    @StateObject var viewModel = SignUpViewModel()
    let messageCallback: ((String) -> Void)?
    
    var body: some View {
        VStack {
            ScrollView {
                SignUpTopView()
                    .padding(.bottom, 30)
                SignUpInputView(viewModel: viewModel)
                    .alert("Signup Successful", isPresented: $isShowingSuccess) {
                        Button("Ok") {
                            self.isShowingSuccess = false
                            self.showSignUpView = false
                        }
                    }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
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
//                HStack {
//                    Text("Date of Birth")
//                    Spacer()
//                }
//                HStack {
//                    TextField("Day", text: $user.dobDay)
//                        .padding(.trailing, 10)
//                        .keyboardType(.numberPad)
//                    TextField("Month", text: $user.dobMonth)
//                        .padding(.trailing, 10)
//                        .keyboardType(.numberPad)
//                    TextField("Year", text: $user.dobYear)
//                        .keyboardType(.numberPad)
//                }
                
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
//                    Button {
//
//                    } label: {
//                        Text("Fetch")
//                            .foregroundColor(AppColor.colorPrimary)
//                            .font(Font.custom("gilroy-semibold", size: 18))
//                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
//                    }
//                    .background(AppColor.colorLightGray)
//                    .cornerRadius(20)
//                    .padding(.leading, 30)
                    
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
                viewModel.registeruser()
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
        SignUpView(showSignUpView: self.$showSignUpView, messageCallback: nil)
            .previewDevice("iPhone 11")
    }
}
