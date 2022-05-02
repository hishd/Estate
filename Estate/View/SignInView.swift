//
//  ContentView.swift
//  NIBM Broker
//
//  Created by Hishara Dilshan on 2022-03-26.
//

import SwiftUI

struct SignInView: View {
    let screenHeight: Int = Int(UIScreen.main.bounds.height)
    
    var body: some View {
        VStack {
            if screenHeight > 667 {
                LargeScaleDevice()
            } else {
                SmallScaleDevice()
            }
        }
    }
}

struct LargeScaleDevice: View {
    @StateObject private var signInViewModel = SignInViewModel()
    var body: some View {
        NavigationView {
            VStack {
                SignInTopView(showSignUpView: $signInViewModel.showSignUpView)
                Spacer()
                SignInInputView(signInViewModel: signInViewModel, isSmallDevice: false)
                SignInForgotPasswordView()
                SignInBottomView(signInViewModel: signInViewModel)
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct SmallScaleDevice: View {
    @StateObject private var signInViewModel = SignInViewModel()
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    SignInTopView(showSignUpView: $signInViewModel.showSignUpView)
                    Spacer()
                    SignInInputView(signInViewModel: signInViewModel, isSmallDevice: true)
                    SignInForgotPasswordView()
                    SignInBottomView(signInViewModel: signInViewModel)
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct SignInTopView: View {
    @Binding var showSignUpView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink("Sign Up", destination: SignUpView(showSignUpView: $showSignUpView), isActive: $showSignUpView)
                    .navigationTitle("Sign in")
                    .foregroundColor(AppColor.colorPrimary)
                    .font(Font.custom("gilroy-semibold", size: 18))
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 30))
        }
    }
}

struct SignInInputView: View {
    @ObservedObject var signInViewModel: SignInViewModel
    let isSmallDevice: Bool
    
    var body: some View {
        VStack {
            Image("img-logo")
                .resizable()
                .frame(width: 240, height: 120, alignment: .center)
                .padding(
                    isSmallDevice ?
                    EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0) :
                        EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)
                )
            
            ErrorDisplayView(isShown: $signInViewModel.isError, message: $signInViewModel.errorCaption)
            
            VStack {
                HStack {
                    Text("Email Address")
                    Spacer()
                }
                TextField("Enter Email Address", text: $signInViewModel.emailAddress)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .onChange(of: signInViewModel.emailAddress) { newValue in
                        signInViewModel.isValidEmail = FieldValidator.shared.isValidEmailAddress(of: signInViewModel.emailAddress)
                    }
                ErrorPlaceholder(isValid: $signInViewModel.isValidEmail, message: ValidationCaptions.invalidEmail.rawValue)
                    .frame(height: 20, alignment: .trailing)
            }.padding([.leading, .trailing, .top],30)
            
            VStack {
                HStack {
                    Text("Password")
                    Spacer()
                }
                SecureField("Enter Password", text: $signInViewModel.password)
                    .onChange(of: signInViewModel.password) { newValue in
                        signInViewModel.isValidPassword = FieldValidator.shared.isValidPassword(of: signInViewModel.password)
                    }
                ErrorPlaceholder(isValid: $signInViewModel.isValidPassword, message: ValidationCaptions.invalidPassword.rawValue)
                    .frame(height: 20, alignment: .trailing)
                    
            }.padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
            
        }
        .font(Font.custom("gilroy-regular", size: 18))
        .textFieldStyle(.roundedBorder)
        .onAppear {
            signInViewModel.isError = true
            signInViewModel.errorCaption = "Sample Error"
        }
    }
}


struct SignInForgotPasswordView: View {
    var body: some View {
        HStack {
            Spacer()
            Button {
                
            } label: {
                Text("Forgot Password")
            }
            .foregroundColor(AppColor.colorPrimary)
            .font(Font.custom("gilroy-medium", size: 16))
            
        }.padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 30))
    }
}

struct SignInBottomView: View {
    @ObservedObject var signInViewModel: SignInViewModel
    
    var body: some View {
        VStack {
            Button {
                signInViewModel.userSignIn(emailAddress: signInViewModel.emailAddress, password: signInViewModel.password)
            } label: {
                Text(signInViewModel.isSignedIn ? "Success" : "Sign In")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .font(Font.custom("gilroy-semibold", size: 18))
            }
            .background(AppColor.colorPrimary)
            .cornerRadius(18)
            .padding(.top, 20)
            
            VStack {
                Text("By continuing, you agree to NIBM Broker App's")
                    .foregroundColor(AppColor.colorGray)
                    .font(Font.custom("gilroy-medium", size: 13))
                Button {
                    
                } label: {
                    Text("Terms & Privacy Policy")
                        .foregroundColor(AppColor.colorPrimary)
                        .font(Font.custom("gilroy-semibold", size: 13))
                        .padding(.top, 2)
                }
            }
            .padding(.top, 20)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .previewDevice("iPhone 8")
        SignInView()
            .previewDevice("iPhone 11")
    }
}
