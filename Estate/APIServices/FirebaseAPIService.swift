//
//  Firestore.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-31.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseAPIService: WebService {
    static let shared = FirebaseAPIService()
    private let db = Firestore.firestore()
    weak var ref: DocumentReference?
    lazy var auth = Auth.auth()
    
    private init() {}
}


// MARK: Authenticate Based Concrete Implementation
extension FirebaseAPIService {
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func performSignIn(emailAddress: String, password: String) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            let auth = Auth.auth()
            auth.signIn(withEmail: emailAddress, password: password) { result, error in
                guard result != nil, error == nil else {
                    debugPrint(error?.localizedDescription ?? "")
                    continuation.resume(throwing: SignInError.operationError)
                    return
                }
                
                continuation.resume(returning: true)
            }
        }
    }
    
    func performSignOut() throws {
        try auth.signOut()
    }
    
    func performRegistration(user: User) async throws -> Bool {
        guard try await checkAndCreateAuthAccount(email: user.emailAddress, password: user.password), try await createUseronDB(user: user) else {
            return false
        }
        
        return true
    }
    
    private func checkAndCreateAuthAccount(email: String, password: String) async throws -> Bool {
        try await withCheckedThrowingContinuation({ continuation in
            self.db.collection("users")
                .whereField("emailAddress", isEqualTo: email)
                .getDocuments { snapshot, error in
                    
                    if let error = error {
                        debugPrint(error)
                        continuation.resume(throwing: FirebaseOperationError.unknown)
                    }
                    
                    guard let snapshot = snapshot else {
                        continuation.resume(throwing: FirebaseOperationError.noData)
                        return
                    }
                    
                    ///Check if the snapshot contains any data (existing data means theres already a user with the given email)
                    if snapshot.documents.isEmpty {
                        self.auth.createUser(withEmail: email, password: password) { result, error in
                            guard result != nil, error == nil else {
                                debugPrint(error?.localizedDescription ?? "")
                                continuation.resume(throwing: FirebaseOperationError.userCreationFailed)
                                return
                            }
                            
                            continuation.resume(returning: true)
                        }
                    } else {
                        ///Return error - user exists when snapshot contains data
                        continuation.resume(throwing: FirebaseOperationError.userExists)
                    }
                }
        })
    }
    
    private func createUseronDB(user: User) async throws -> Bool {
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
                        continuation.resume(throwing: FirebaseOperationError.unknown)
                    } else {
                        continuation.resume(returning: true)
                    }
                }
        }
    }
}

// MARK: User Based Concrete Implementation
extension FirebaseAPIService {
    func getUserDataAsync(by email: String) async throws -> User? {
        try await withCheckedThrowingContinuation({ continuation in
            self.db.collection("users")
                .whereField("emailAddress", isEqualTo: email)
                .getDocuments { snapshot, error in
                    if let error = error {
                        debugPrint(error)
                        continuation.resume(throwing: FirebaseOperationError.userDataNotFound)
                    }
                    
                    guard let userData = snapshot?.documents.first?.data() else {
                        continuation.resume(throwing: FirebaseOperationError.noData)
                        return
                    }
                    
                    continuation.resume(returning:
                                            User(nicNo: userData["nicNo"] as! String,
                                                name: userData["name"] as! String,
                                                mobileNo: userData["mobileNo"] as! String,
                                                emailAddress: userData["emailAddress"] as! String,
                                                gender: userData["gender"] as! String,
                                                locationLat: userData["locationLat"] as! Double,
                                                locationLon: userData["locationLon"] as! Double)
                    )
                }
        })
    }
    
    func updateUser(mobileNo: String, locationLat: Double, locationLon: Double) async throws -> Bool {
        return false
    }
    
    func updatePassword(of email: String, of current: String, with new: String) async throws -> Bool {
        return false
    }
}

// MARK: Ads based Concrete Implementation
extension FirebaseAPIService {
    func fetchAllAds() async throws -> [AddItem] {
        return []
    }
    
    func filterAds(by district: String) async throws -> [AddItem] {
        return []
    }
    
    func filterAds(minPrice: Double, maxPrice: Double, maxRadius: Int, isLand: Bool) async throws -> [AddItem] {
        return []
    }
    
    func fetchMyAds(by email: String) async throws -> [AddItem] {
        return []
    }
    
    func removeAdd(by addId: String) async throws -> Bool {
        return false
    }
    
    func updateAdd(by addId: String, with addItem: AddItem) async throws -> Bool {
        return false
    }
    
    func postNewAdd(of content: NewAddContent) async throws -> Bool {
        return false
    }
}

public enum FirebaseOperationError: Error {
    case userExists
    case userCreationFailed
    case userDataNotFound
    case noData
    case unknown
}

extension FirebaseOperationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userExists:
            return NSLocalizedString("User already exists with email address", comment: "User already exists")
        case .userCreationFailed:
            return NSLocalizedString("User creation failed with error", comment: "User creation failed")
        case .userDataNotFound:
            return NSLocalizedString("User data not found", comment: "User data not found")
        case .noData:
            return NSLocalizedString("No data found", comment: "No Data found")
        case .unknown:
            return NSLocalizedString("unknown error occurred while creating user", comment: "Unknown error")
        }
    }
}
