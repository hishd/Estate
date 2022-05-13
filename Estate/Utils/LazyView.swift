//
//  LazyView.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-05-13.
//

import Foundation
import SwiftUI

struct LazyView<T: View> : View {
    var view: () -> T
    var body: some View {
        self.view()
    }
}
