//
//  SafeAreaBottomPadding.swift
//
//
//  Created by El Mostafa El Ouatri on 27/09/23.
//

import SwiftUI

struct SafeAreaBottomPadding: ViewModifier {
    func body(content: Content) -> some View {
        if UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 {
            content.padding(.bottom)
        } else {
            content
        }
    }
}

extension View {
    public func safeAreaBottomPadding() -> some View {
        modifier(SafeAreaBottomPadding())
    }
}
