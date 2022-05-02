//
//  NewAddViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-06.
//

import Foundation
import UIKit

class PostAddViewModel: ObservableObject, PostAddService {
    @Published var addItem = NewAddItem(addItem: AddItem())
    @Published var isError = false
    
    // MARK: Input Fields
    @Published var price: String = ""
    @Published var landSize: String = ""
    @Published var district: DistrictNames = .colombo
    @Published var town: String = ""
    @Published var location: String = ""
    @Published var isLand: Bool = true
    @Published var information: String = ""
    
    // MARK: Input Field Validations
    @Published var isValidPrice = true
    @Published var isValidLandSize = true
    @Published var isValidTown = true
    @Published var isValidLocation = true
    @Published var isValidInformation = true
    
    init() {
        //TODO: Remove after the initial testing
        addItem.addImages = [
            UIImage(named: "land1")!,
            UIImage(named: "land2")!,
            UIImage(named: "land3")!,
            UIImage(named: "land1")!
        ]
    }
    
    func validateInput() -> Bool {
        if !FieldValidator.shared.isValidPrice(of: self.price) {
            self.isValidPrice = false
            return false
        }
        
        if !FieldValidator.shared.isValidLandSize(of: self.landSize) {
            self.isValidLandSize = false
            return false
        }
        
        if !FieldValidator.shared.isValidTownName(of: self.town) {
            self.isValidTown = false
            return false
        }
        
        if location.isEmpty {
            self.isValidLocation = false
            return false
        }
        
        if !FieldValidator.shared.isValidAddInfo(of: self.information) {
            self.isValidInformation = false
            return false
        }
        
        return true
    }
    
    func removeSelectedAddImage(at index: Int) {
        self.addItem.addImages.remove(at: index)
    }
    
    // MARK: Concrete Implementation
    func postNewAdd(of content: NewAddContent) {
        
    }
}

struct NewAddItem {
    var addItem: AddItem
    var deedImage: UIImage? = UIImage(named: "land1")
    var addImages: [UIImage] = []
}
