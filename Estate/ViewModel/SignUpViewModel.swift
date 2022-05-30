//
//  SignUpViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-03-30.
//

import Foundation
import CoreLocation

class SignUpViewModel: NSObject, ObservableObject {
    @Published var name: String = ""
    @Published var emailAddress: String = ""
    @Published var nicNo: String = ""
    @Published var mobileNo: String = ""
    @Published var isMale: Bool = true
    @Published var dob: Date = Date()
    @Published var currentLocation: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var errorSignup = false
    @Published var errorSignupMessage: String = ""
    
    @Published var isOnProgress = false
    @Published var isShowingSuccess = false
    
    lazy var manager: CLLocationManager = {
        var locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 50.0
        locationManager.allowsBackgroundLocationUpdates = false
        return locationManager
    }()
    
    var locationLat: Double = 0
    var locationLon: Double = 0
    
    // MARK: - Input Field Validations
    @Published var isValidName: Bool = true
    @Published var isValidEmail: Bool = true
    @Published var isValidNIC: Bool = true
    @Published var isValidMobile: Bool = true
    @Published var isValidLocation: Bool = true
    @Published var isValidPassword: Bool = true
    @Published var isMatchingPasswords: Bool = true
    
    override init() {
        super.init()
    }
}

extension SignUpViewModel {
    @MainActor
    private func validateInput() -> Bool {
        if !FieldValidator.shared.isValidNIC(of: nicNo) {
            isValidNIC = false
            return false
        }
        if !FieldValidator.shared.isValidPersonName(of: name) {
            isValidName = false
            return false
        }
        if !FieldValidator.shared.isValidMobileNo(of: mobileNo) {
            isValidMobile = false
            return false
        }
        if currentLocation.isEmpty {
            isValidLocation = false
            return false
        }
        if !FieldValidator.shared.isValidEmailAddress(of: emailAddress) {
            isValidEmail = false
            return false
        }
        if !FieldValidator.shared.isValidPassword(of: password) {
            isValidPassword = false
            return false
        }
        if !password.elementsEqual(confirmPassword) {
            isMatchingPasswords = false
            return false
        }
        
        return true
    }
}

// MARK: Concrete Methods Implementation
extension SignUpViewModel: AuthenticationService {
    @MainActor
    func performRegistration() async {
        //Final check of the input fields
        self.isOnProgress = true
        if validateInput() {
            do {
                let user = User(nicNo: self.nicNo,
                                password: self.password,
                                name: self.name,
                                mobileNo: self.mobileNo,
                                emailAddress: self.emailAddress,
                                dob: self.dob,
                                gender: self.isMale ? "Male" : "Female",
                                locationLat: self.locationLat,
                                locationLon: self.locationLon)
                guard try await user.signUp(user: user) else {
                    return
                }
                self.isOnProgress = false
                self.isShowingSuccess = true
            } catch {
                self.errorSignup = true
                switch error {
                case let error as FirebaseOperationError:
                    self.errorSignupMessage = error.localizedDescription
                default:
                    self.errorSignupMessage = FirebaseOperationError.unknown.localizedDescription
                }
            }
        }
        self.isOnProgress = false
    }
}

extension SignUpViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            self.locationLat = location.latitude
            self.locationLon = location.longitude
            self.currentLocation = String(format: "Lat: %.4f Lon: %.4f", location.latitude, location.longitude)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard case .authorizedWhenInUse = manager.authorizationStatus else {
            self.isValidLocation = false
            return
        }
        
        self.isValidLocation = true
    }
    
    func loadCurrentLocation() {
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
            self.isValidLocation = true
        } else {
            self.isValidLocation = false
        }
    }
}
