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
    @Published var district: String = ""
    @Published var town: String = ""
    @Published var location: String = ""
    @Published var isLand: String = ""
    @Published var information: String = ""
    
    // MARK: Input Field Validations
    @Published var isValidPrice = true
    @Published var isValidLandSize = true
    @Published var isValidTown = true
    @Published var isValidLocation = true
    @Published var isValidInformation = true
    
    init() {
        addItem.addImages = [UIImage(named: "land1")!, UIImage(named: "land2")!, UIImage(named: "land3")!, UIImage(named: "land1")!]
    }
    
    func validateInput() -> Bool {
        !if FieldValidator.shared.
        
        return true
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
