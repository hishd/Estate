//
//  ContentView.swift
//  NIBM Broker
//
//  Created by Hishara Dilshan on 2022-03-26.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var signInViewModel = SignInViewModel()
    @State var showSignUpView = false
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    SignInTopView(showSignUpView: $showSignUpView)
                    Spacer()
                    SignInInputView(user: $signInViewModel.user)
                    SignInForgotPasswordView()
                    SignInBottomView(user: $signInViewModel.user)
                    Spacer()
                    
                    NavigationLink("Sign Up", destination: SignUpView(), isActive: $showSignUpView)
                        .navigationTitle("Sign in")
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct SignInTopView: View {
    @Binding var showSignUpView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    showSignUpView = true
                } label: {
                    Text("Sign up")
                }
                .foregroundColor(Color("color-primary"))
                .font(Font.custom("gilroy-semibold", size: 18))
            }.padding()
        }
    }
}

struct SignInBottomView: View {
    
    @Binding var user: User
    @State var signedIn: Bool = false
    
    var body: some View {
        VStack {
            Button {
                Task {
                    do {
                        let (result) = try await user.signInAsync(emailAddress: user.emailAddress, password: user.password)
                        self.signedIn = result
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                }
            } label: {
                Text(self.signedIn ? "Success" : "Sign In")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .font(Font.custom("gilroy-semibold", size: 18))
            }
            .background(Color("color-primary"))
            .cornerRadius(18)
            .padding(.top, 20)
            
            VStack {
                Text("By continuing, you agree to NIBM Broker App's")
                    .foregroundColor(Color("color-gray"))
                    .font(Font.custom("gilroy-medium", size: 13))
                Button {
                    
                } label: {
                    Text("Terms & Privacy Policy")
                        .foregroundColor(Color("color-primary"))
                        .font(Font.custom("gilroy-semibold", size: 13))
                        .padding(.top, 2)
                }
            }
            .padding(.top, 20)
        }
    }
}

struct SignInInputView: View {
    
    @Binding var user: User
    
    var body: some View {
        VStack {
            
            Image("img-logo")
                .resizable()
                .frame(width: 240, height: 120, alignment: .center)
                .padding(.bottom, 30)
            
            VStack {
                HStack {
                    Text("Email Address")
                    Spacer()
                }
                TextField("Enter Email Address", text: $user.emailAddress)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
            }.padding([.leading, .trailing, .top],30)
            
            VStack {
                HStack {
                    Text("Password")
                    Spacer()
                }
                SecureField("Enter Password", text: $user.password)
                    
            }.padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
            
        }
        .font(Font.custom("gilroy-regular", size: 18))
        .textFieldStyle(.roundedBorder)
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
            .foregroundColor(Color("color-primary"))
            .font(Font.custom("gilroy-medium", size: 16))
            
        }.padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 30))
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
