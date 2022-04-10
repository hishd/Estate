//
//  SignUpView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-31.
//

import SwiftUI

struct SignUpView: View {
    
    @State var isShowingSuccess = false
    @Binding var showSignUpView: Bool
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                SignUpTopView()
                    .padding(.bottom, 30)
                SignUpInputView(user: $viewModel.user, viewModel: viewModel)
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
    @Binding var user: User
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("NIC Number")
                    Spacer()
                }
                TextField("Enter NIC Number", text: $user.nicNo)
                    .onChange(of: user.nicNo) { newValue in
                        viewModel.isValidNIC = FieldValidator.shared.isValidNIC(of: newValue)
                    }
                ErrorPlaceholder(isValid: $viewModel.isValidNIC, message: ValidationCaptions.invalidNIC.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Your Name")
                    Spacer()
                }
                TextField("Enter Name", text: $user.name)
                    .textContentType(.name)
                    .onChange(of: user.name) { newValue in
                        viewModel.isValidName = FieldValidator.shared.isValidPersonName(of: newValue)
                    }
                ErrorPlaceholder(isValid: $viewModel.isValidName,message: ValidationCaptions.invalidName.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Mobile Number")
                    Spacer()
                }
                TextField("Enter Mobile no.", text: $user.mobileNo)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.namePhonePad)
                    .onChange(of: user.mobileNo) { newValue in
                        viewModel.isValidMobile = FieldValidator.shared.isValidMobileNo(of: newValue)
                    }
                ErrorPlaceholder(isValid: $viewModel.isValidMobile, message: ValidationCaptions.invalidMobileNo.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Email Address")
                    Spacer()
                }
                TextField("Enter Email Address", text: $user.emailAddress)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .onChange(of: user.emailAddress) { newValue in
                        viewModel.isValidEmail = FieldValidator.shared.isValidEmailAddress(of: newValue)
                    }
                ErrorPlaceholder(isValid: $viewModel.isValidEmail, message: ValidationCaptions.invalidEmail.rawValue)
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
                
                DatePicker(selection: $user.dob, in: ...Date(), displayedComponents: .date) {
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
                
                ErrorPlaceholder(isValid: $viewModel.isValidLocation, message: ValidationCaptions.invalidLocation.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Password")
                    Spacer()
                }
                SecureField("Enter Password", text: $user.password)
                    .onChange(of: user.password) { newValue in
                        viewModel.isValidPassword = FieldValidator.shared.isValidPassword(of: user.password)
                        viewModel.isMatchingPasswords = user.password.elementsEqual(viewModel.confPassword)
                    }
                ErrorPlaceholder(isValid: $viewModel.isValidPassword, message: ValidationCaptions.invalidPassword.rawValue)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            
            VStack {
                HStack {
                    Text("Confirm Password")
                    Spacer()
                }
                SecureField("Re-enter Password", text: $viewModel.confPassword)
                    .onChange(of: viewModel.confPassword) { newValue in
                        viewModel.isMatchingPasswords = user.password.elementsEqual(viewModel.confPassword)
                    }
                ErrorPlaceholder(isValid: $viewModel.isMatchingPasswords, message: ValidationCaptions.passwordsNoMatch.rawValue)
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
        SignUpView(showSignUpView: self.$showSignUpView)
            .previewDevice("iPhone 11")
    }
}
