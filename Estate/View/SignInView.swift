//
//  ContentView.swift
//  NIBM Broker
//
//  Created by Hishara Dilshan on 2022-03-26.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var signInViewModel = SignInViewModel()
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    TopView()
                    Spacer()
                    InputView(user: $signInViewModel.user)
                    ForgotPasswordView()
                    BottomView(user: $signInViewModel.user)
                    Spacer()
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct TopView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("Sign up")
                }
                .foregroundColor(Color("color-primary"))
                .font(Font.custom("gilroy-semibold", size: 18))
            }.padding()
        }
    }
}

struct BottomView: View {
    
    @Binding var user: User
    @State var signedIn: Bool = false
    
    var body: some View {
        VStack {
            Button {
                Task {
                    let (result) = try? await user.signInAsync(emailAddress: user.emailAddress, password: user.password)
                    if let result = result {
                        self.signedIn = result
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

struct InputView: View {
    
    @Binding var user: User
    
    var body: some View {
        VStack {
            
            Image("img-logo")
                .resizable()
                .frame(width: 240, height: 90, alignment: .center)
                .padding(.bottom, 30)
            
            VStack {
                HStack {
                    Text("Username")
                    Spacer()
                }
                TextField("Enter User Name", text: $user.emailAddress)
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


struct ForgotPasswordView: View {
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
