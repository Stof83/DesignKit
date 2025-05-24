//
//  BorderStyle.swift
//
//
//  Created by El Mostafa El Ouatri on 02/08/23.
//

import SwiftUI

/// A custom ViewModifier to apply a border to a SwiftUI view.
///
/// The `BorderStyle` allows you to add a border with the specified width, color, and corner radius to any SwiftUI view.
/// You can apply this modifier to any view in your SwiftUI code to customize its border appearance.
///
/// Example usage:
/// ```
/// Text("Hello, World!")
///     .borderStyle(width: 2.0, color: .blue, cornerRadius: 10)
/// ```
struct BorderStyle: ViewModifier {

    // MARK: - Public Properties

    /// The width of the border.
    var width: CGFloat = 1.0

    /// The color of the border.
    var color: Color = .gray

    /// The corner radius of the border.
    var cornerRadius: CGFloat = 0.0

    /// Applies the border style to the content view.
    ///
    /// - Parameter content: The content view to which the border style is applied.
    /// - Returns: A view with the border style applied.
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: width)
            )
    }
}

extension View {
    /// Applies a border style to the view.
    ///
    /// - Parameters:
    ///   - width: The width of the border. Default is `1.0`.
    ///   - color: The color of the border. Default is `.gray`.
    ///   - cornerRadius: The corner radius of the border. Default is `0.0`.
    /// - Returns: A view with the border style applied.
    public func borderStyle(width: CGFloat = 1.0, color: Color = .gray, cornerRadius: CGFloat = 0.0) -> some View {
        modifier(BorderStyle(width: width, color: color, cornerRadius: cornerRadius))
    }
}


