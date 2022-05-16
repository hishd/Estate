//
//  ErrorPlaceholderView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-02.
//

import Foundation
import SwiftUI

struct TextFieldErrorPlaceholder: View {
    @Binding var isValid: Bool
    let message: String
    
    var body: some View {
        if !isValid {
            Text(message)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .foregroundColor(.red)
                .font(Font.custom("gilroy-regular", size: 15))
        }
    }
}
