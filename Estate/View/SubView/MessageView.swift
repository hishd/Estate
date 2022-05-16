//
//  MessageView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-05-16.
//

import Foundation
import SwiftUI

struct MessageView: View {
    @Binding var isShown: Bool
    @Binding var message: String
    @Binding var color: Color
    var body: some View {
        if isShown {
            Text(message)
                .foregroundColor(color)
                .font(Font.custom("gilroy-regular", size: 15))
        }
    }
}
