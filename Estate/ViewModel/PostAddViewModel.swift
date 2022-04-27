//
//  NewAddViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-06.
//

import Foundation
import UIKit

class PostAddViewModel: ObservableObject {
    @Published var addItem = NewAddItem(addItem: AddItem())
    
    init() {
        addItem.addImages = [UIImage(named: "land1")!, UIImage(named: "land2")!, UIImage(named: "land3")!, UIImage(named: "land1")!]
    }
}

struct NewAddItem {
    var addItem: AddItem
    var deedImage: UIImage? = UIImage(named: "land1")
    var addImages: [UIImage] = []
}
