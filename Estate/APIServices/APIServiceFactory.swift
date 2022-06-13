//
//  APIServiceFactory.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-06-13.
//

import Foundation

class APIServiceFactory {
    class func getApiService() -> WebService {
        let environment = ProcessInfo.processInfo.environment["ENV"]
        if environment == "TEST" {
            return FakeAPIService.shared
        } else {
            return FirebaseAPIService.shared
        }
    }
}
