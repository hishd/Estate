//
//  ErrorDisplayView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-02.
//

import Foundation
import SwiftUI

struct ErrorMessage: View {
    @Binding var isShown: Bool
    @Binding var message: String
    var body: some View {
        if isShown {
            Text(message)
                .foregroundColor(.red)
                .font(Font.custom("gilroy-semibold", size: 15))
        }
    }
}
