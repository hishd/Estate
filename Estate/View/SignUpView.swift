//
//  SignUpView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-31.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack {
            ScrollView {
                SignUpTopView()
                    .padding(.bottom, 30)
                SignUpInputView()
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
                .foregroundColor(Color("color-primary"))
                .font(Font.custom("gilroy-bold", size: 22))
        }
    }
}

struct SignUpInputView: View {
    @State var nicNumber: String = ""
    @State var name: String = ""
    @State var mobileNo: String = ""
    @State var emailAddress: String = ""
    @State var dDob: String = ""
    @State var mDob: String = ""
    @State var yDob: String = ""
    @State var isMale: Bool = true
    @State var location: String = ""
    @State var password: String = ""
    @State var confPassword: String = ""
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("NIC Number")
                    Spacer()
                }
                TextField("Enter NIC Number", text: $nicNumber)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Your Name")
                    Spacer()
                }
                TextField("Enter Name", text: $name)
                    .textContentType(.name)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Mobile Number")
                    Spacer()
                }
                TextField("Enter Mobile no.", text: $mobileNo)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.namePhonePad)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Email Address")
                    Spacer()
                }
                TextField("Enter Email Address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Date of Birth")
                    Spacer()
                }
                HStack {
                    TextField("Day", text: $dDob)
                        .padding(.trailing, 10)
                        .keyboardType(.numberPad)
                    TextField("Month", text: $mDob)
                        .padding(.trailing, 10)
                        .keyboardType(.numberPad)
                    TextField("Year", text: $yDob)
                        .keyboardType(.numberPad)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            
            HStack {
                Text("Gender : \(isMale ? "Male" : "Female")")
                Toggle("", isOn: $isMale)
                    .tint(Color("color-primary"))
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            
            VStack {
                HStack {
                    Text("Location")
                    Spacer()
                }
                HStack {
                    TextField("Press Fetch to load", text: $location)
                        .disabled(true)
                    Button {
                        
                    } label: {
                        Text("Fetch")
                            .foregroundColor(Color("color-primary"))
                            .font(Font.custom("gilroy-semibold", size: 18))
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    }
                    .background(Color("color-lightgray"))
                    .cornerRadius(20)
                    .padding(.leading, 30)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 30))
            
            VStack {
                HStack {
                    Text("Password")
                    Spacer()
                }
                SecureField("Enter Password", text: $password)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            
            VStack {
                HStack {
                    Text("Confirm Password")
                    Spacer()
                }
                SecureField("Re-enter Password", text: $confPassword)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            
            Button {
                
            } label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .font(Font.custom("gilroy-semibold", size: 18))
            }
            .background(Color("color-primary"))
            .cornerRadius(18)
            .padding(.top, 10)
        }
        .font(Font.custom("gilroy-regular", size: 18))
        .textFieldStyle(.roundedBorder)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .previewDevice("iPhone 11")
    }
}
