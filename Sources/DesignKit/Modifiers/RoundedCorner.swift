//
//  RoundedCorner.swift
//
//
//  Created by El Mostafa El Ouatri on 25/09/23.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    public func roundedCorner(_ radius: CGFloat, corners: UIRectCorner = [.allCorners]) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
