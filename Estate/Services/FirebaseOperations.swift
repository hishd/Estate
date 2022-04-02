//
//  Firestore.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-31.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseOperations {
    static let shared = FirebaseOperations()
    private let db = Firestore.firestore()
    weak var ref: DocumentReference?
    lazy var auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    private init() {
        
    }
    
    func signInAsync(emailAddress: String, password: String) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            let auth = Auth.auth()
            auth.signIn(withEmail: emailAddress, password: password) { [weak self] result, error in
                guard result != nil, error == nil else {
                    debugPrint(error)
                    continuation.resume(throwing: SignInError.operationError)
                    return
                }
                
                continuation.resume(returning: true)
            }
        }
    }
    
    func registerUserAsync(user: User) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YYYY"
            self.db.collection("users")
                .addDocument(data: [
                    "nicNo" : user.nicNo,
                    "name": user.name,
                    "mobileNo": user.mobileNo,
                    "emailAddress": user.emailAddress,
                    "dob": dateFormatter.string(from: user.dob),
                    "gender": user.gender,
                    "locationLat": user.locationLat,
                    "locationLon": user.locationLon
                ]) { error in
                    if let error = error {
                        debugPrint(error)
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: true)
                    }
                }
        }
    }
}
