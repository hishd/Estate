//
//  Firestore.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-31.
//

import Foundation
import FirebaseFirestore

class FirestoreDB {
    static let shared = FirestoreDB()
    private let db = Firestore.firestore()
    weak var ref: DocumentReference?
    
    private init() {}
    
    func registerUserAsync(user: User) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            self.db.collection("users")
                .addDocument(data: [
                    "nicNo" : user.nicNo,
                    "name": user.name,
                    "mobileNo": user.mobileNo,
                    "emailAddress": user.emailAddress,
                    "dobDay": user.dobDay,
                    "dobMonth": user.dobMonth,
                    "dobYear": user.dobYear,
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
