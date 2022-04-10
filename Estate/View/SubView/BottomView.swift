//
//  BottomFilterView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-10.
//

import SwiftUI

struct BottomView<Content: View>: View {
    let maxHeight: CGFloat
    let content: Content
    
    init(maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.maxHeight = maxHeight
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    self.content
                }
                .background(Color.white)
            }
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .frame(height: geometry.size.height, alignment: .bottom)
        }
    }
}

