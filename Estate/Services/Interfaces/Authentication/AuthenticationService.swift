//
//  AuthenticationService.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-19.
//

import Foundation

protocol AuthenticationService {
    @MainActor
    func performSignIn() async
    @MainActor
    func performRegistration() async
}

extension AuthenticationService {
    @MainActor
    func performSignIn() async {}
    @MainActor
    func performRegistration() async {}
}
