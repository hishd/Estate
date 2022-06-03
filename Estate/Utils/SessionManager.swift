//
//  SessionManager.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-06-03.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    
    private init() {}
    
    ///Set the Logged in status of the user to navigate to Home on Launch
    var authState: Bool {
        get {
            UserDefaults.standard.bool(forKey: SessionManagerKeys.authState.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: SessionManagerKeys.authState.rawValue)
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
    
    func getUserSession() throws -> User? {
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
}
