//
//  NewAddViewModel.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-06.
//

import Foundation
import UIKit

class NewAddViewModel: ObservableObject {
    @Published var addItem = NewAddItem(addItem: AddItem())
}

struct NewAddItem {
    var addItem: AddItem
    var deedImage: UIImage?
    var addImages: [UIImage]?
}
