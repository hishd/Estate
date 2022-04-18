//
//  ChangePasswordView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-19.
//

import SwiftUI

struct ChangePasswordView: View {
    @StateObject var viewModel = ChangePasswordViewModel()
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                HStack {
                    Text("Current Password")
                    Spacer()
                }
                SecureField("Enter current Password", text: $viewModel.currentPassword)
                ErrorPlaceholder(isValid: $viewModel.isCorrectCurrentPassword, message: ValidationCaptions.passwordsNoMatch.rawValue)
            }
            
            VStack {
                HStack {
                    Text("New Password")
                    Spacer()
                }
                SecureField("Enter new Password", text: $viewModel.newPassword)
                    .onChange(of: viewModel.newPassword) { newValue in
                        viewModel.isValidPassword = FieldValidator.shared.isValidPassword(of: viewModel.newPassword)
                        viewModel.isMatchingPasswords = viewModel.newPassword.elementsEqual(viewModel.confirmPassword)
                    }
                ErrorPlaceholder(isValid: $viewModel.isValidPassword, message: ValidationCaptions.invalidPassword.rawValue)
            }
            
            VStack {
                HStack {
                    Text("Confirm Password")
                    Spacer()
                }
                SecureField("Re-enter Password", text: $viewModel.confirmPassword)
                    .onChange(of: viewModel.confirmPassword) { newValue in
                        viewModel.isMatchingPasswords = viewModel.newPassword.elementsEqual(viewModel.confirmPassword)
                    }
                ErrorPlaceholder(isValid: $viewModel.isMatchingPasswords, message: ValidationCaptions.passwordsNoMatch.rawValue)
            }
            
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
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 20)
        .padding(.top, 40)
        .font(Font.custom("gilroy-regular", size: 18))
        .textFieldStyle(.roundedBorder)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
