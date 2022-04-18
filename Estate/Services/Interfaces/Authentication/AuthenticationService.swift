//
//  AuthenticationService.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-19.
//

import Foundation

protocol AuthenticationService {
    func performSignIn(email: String, password: String)
}
