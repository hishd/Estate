//
//  SessionManager.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-06-03.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var loggedIn: Bool = false
    
    static let shared = UserSettings()
    
    private init() {
        loggedIn = self.authState
    }
    
    ///Set the Logged in status of the user to navigate to Home on Launch
    var authState: Bool {
        get {
            UserDefaults.standard.bool(forKey: SessionManagerKeys.authState.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: SessionManagerKeys.authState.rawValue)
        }
    }
    
    var currentUser: User? {
        guard let session = UserDefaults.standard.string(forKey: SessionManagerKeys.userSession.rawValue) else {
            NSLog("Previous Sessions not found")
            return nil
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: session.data(using: .utf8)!)
            return user
        } catch {
            fatalError("Could not decode the UserData from session.")
        }
    }
    
    func saveUserSession(for user: User) throws {
        do {
            let jsonData = try JSONEncoder().encode(user)
            let data = String(data: jsonData, encoding: String.Encoding.utf8)
            UserDefaults.standard.set(data, forKey: SessionManagerKeys.userSession.rawValue)
        } catch {
            fatalError("Could not encode the UserData while saving session.")
        }
    }
    
    func clearUserSession() {
        UserDefaults.standard.removeObject(forKey: SessionManagerKeys.authState.rawValue)
        UserDefaults.standard.removeObject(forKey: SessionManagerKeys.userSession.rawValue)
    }
    
//    func getUserSession() throws -> User? {
//        guard let session = UserDefaults.standard.string(forKey: SessionManagerKeys.userSession.rawValue) else {
//            NSLog("Previous Sessions not found")
//            return nil
//        }
//
//        do {
//            let user = try JSONDecoder().decode(User.self, from: session.data(using: .utf8)!)
//            return user
//        } catch {
//            fatalError("Could not decode the UserData from session.")
//        }
//    }
}
