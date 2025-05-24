//
//  ListItemStyle.swift
//  
//
//  Created by El Mostafa El Ouatri on 18/06/23.
//

import SwiftUI

/// A custom `ViewModifier` to style list items with padding, background color, and border.
///
/// The `ListItemStyle` modifier adds padding, sets the frame height, applies a background color, and adds a border with a customizable width and color based on the `isSelected` property. It is suitable for applying a consistent style to list items in SwiftUI.
///
/// Example usage:
/// ```
/// Text("List Item")
///     .listItemStyle(isSelected: true, height: 50)
/// ```
struct ListItemStyle: ViewModifier {

    // MARK: - Public Properties

    /// A boolean value indicating whether the list item is selected.
    let isSelected: Bool

    /// The height of the list item.
    let height: CGFloat

    // MARK: - Private Properties

    /// The brand color from the `ThemeManager` used for the border color.
    private let brandColor = ThemeManager.shared.colors.brand

    /// Applies the list item style to the content view.
    ///
    /// - Parameter content: The content view to which the list item style is applied.
    /// - Returns: A view with the list item style applied.
    func body(content: Content) -> some View {
        content
            .padding(10)
            .frame(height: height)
            .background(Color.listItemBackground)
            .cornerRadius(8)
            .borderStyle(
                width: isSelected ? 2 : 0,
                color: brandColor.color,
                cornerRadius: 8
            )
    }
}

extension View {
    /// Apply a consistent style to list items.
    ///
    /// Example usage:
    /// ```
    /// Text("List Item")
    ///     .listItemStyle(isSelected: true, height: 50)
    /// ```
    ///
    /// - Parameters:
    ///   - isSelected: A boolean value indicating whether the list item is selected.
    ///   - height: The height of the list item.
    /// - Returns: A view with the list item style applied.
    public func listItemStyle(isSelected: Bool, height: CGFloat) -> some View {
        modifier(ListItemStyle(isSelected: isSelected, height: height))
    }
}
