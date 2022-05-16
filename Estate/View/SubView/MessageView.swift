//
//  MessageView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-05-16.
//

import Foundation
import SwiftUI

struct MessageView: View {
    @Binding var message: String
    let color: Color
    var body: some View {
        Text(message)
            .foregroundColor(color)
            .font(Font.custom("gilroy-regular", size: 15))
    }
}
