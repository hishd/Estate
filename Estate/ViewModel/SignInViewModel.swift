//
//  SignInViewModel.swift
//  NIBM Broker
//
//  Created by Hishara Dilshan on 2022-03-27.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var user = User()
    @Published var showSignUpView = false
}
