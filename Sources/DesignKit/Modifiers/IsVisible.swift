//
//  File.swift
//  
//
//  Created by El Mostafa El Ouatri on 03/11/23.
//

import SwiftUI

/// A custom `ViewModifier` to hide or show a SwiftUI view based on a boolean value.
///
/// The `isVisible` modifier allows you to conditionally hide or show a SwiftUI view by setting the `hidden` property to `true` or `false`. Additionally, you can choose to either completely remove the view from the layout or just hide it, using the `remove` property.
///
/// Example usage:
/// ```
/// Text("Label")
///     .isHidden(true)
/// ```
struct IsVisible: ViewModifier {

    // MARK: - Public Properties

    /// A boolean value indicating whether the view should be visible.
    var visible = false

    /// A boolean value indicating whether the view should be completely removed from the layout when hidden.
    var remove = false

    /// Applies the hide/show behavior to the content view.
    ///
    /// - Parameter content: The content view to which the hide/show behavior is applied.
    /// - Returns: A view with the hide/show behavior applied.
    func body(content: Content) -> some View {
        if visible {
            content
        } else {
            if !remove {
                content.hidden()
            }
        }
    }
}

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    /// ```
    /// Text("Label")
    ///     .isHidden(true)
    /// ```
    ///
    /// Example for complete removal:
    /// ```
    /// Text("Label")
    ///     .isHidden(true, remove: true)
    /// ```
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: A boolean value indicating whether or not to remove the view from the layout when hidden. Default is `true`.
    /// - Returns: A view with the hide/show behavior applied.
    public func isVisible(_ visible: Bool, remove: Bool = true) -> some View {
        modifier(IsVisible(visible: visible, remove: remove))
    }
}
