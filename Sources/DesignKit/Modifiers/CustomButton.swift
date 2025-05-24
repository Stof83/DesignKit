//
//  CustomButton.swift
//
//
//  Created by El Mostafa El Ouatri on 06/08/23.
//

import SwiftUI

/// A custom `ViewModifier` to apply a custom button style to a SwiftUI view.
///
/// The `CustomButton` allows you to customize the appearance of buttons by setting various properties such as background and foreground colors, corner radius, maximum height, border width, and loading state.
///
/// Example usage:
/// ```
/// Button("Custom Button") {}
///     .customButton(
///         colorSet: ColorSet(backgroundColor: .blue, foregroundColor: .white),
///         maxHeight: 50,
///         cornerRadius: 8,
///         borderWidth: 2
///     )
/// ```
struct CustomButton: ViewModifier {

    // MARK: - Properties

    /// The background color of the button.
    var backgroundColor: Color

    /// The foreground color of the button (text and image color).
    var foregroundColor: Color

    /// The maximum height of the button.
    var maxHeight: CGFloat

    /// The corner radius of the button.
    var cornerRadius: CGFloat

    /// The border width of the button.
    var borderWidth: CGFloat

    /// The font of the button.
    var font: Font

    /// The loading state of the button. When set to `true`, the button displays a loading indicator.
    var isLoading: Bool

    /// Applies the custom button style to the content view.
    ///
    /// - Parameter content: The content view to which the custom button style is applied.
    /// - Returns: A view with the custom button style applied.
    func body(content: Content) -> some View {
        content
            .buttonStyle(
                .customButtonStyle(
                    backgroundColor: backgroundColor,
                    foregroundColor: foregroundColor,
                    maxHeight: maxHeight,
                    cornerRadius: cornerRadius,
                    borderWidth: borderWidth,
                    font: font,
                    isLoading: isLoading
                )
            )
    }
}

extension View {
    /// Applies a custom button style to the view.
    ///
    /// - Parameters:
    ///   - colorSet: A `ColorSet` defining the background and foreground colors of the button.
    ///   - maxHeight: The maximum height of the button. Default is `46`.
    ///   - cornerRadius: The corner radius of the button. Default is `10`.
    ///   - borderWidth: The border width of the button. Default is `0`.
    ///   - isLoading: The loading state of the button. Default is `false`.
    /// - Returns: A view with the custom button style applied.
    public func customButton(
        colorSet: ColorSet,
        maxHeight: CGFloat = 46,
        cornerRadius: CGFloat = 10,
        borderWidth: CGFloat = 0,
        font: Font = .bold(fixedSize: 16),
        isLoading: Bool = false
    ) -> some View {
        modifier(
            CustomButton(
                backgroundColor: colorSet.color,
                foregroundColor: colorSet.overlay,
                maxHeight: maxHeight,
                cornerRadius: cornerRadius,
                borderWidth: borderWidth,
                font: font,
                isLoading: isLoading
            )
        )
    }

    /// Applies a primary button style to the view.
    ///
    /// - Parameters:
    ///   - maxHeight: The maximum height of the button. Default is `46`.
    ///   - cornerRadius: The corner radius of the button. Default is `10`.
    ///   - borderWidth: The border width of the button. Default is `0`.
    ///   - isLoading: The loading state of the button. Default is `false`.
    /// - Returns: A view with the primary button style applied.
    public func primaryButton(
        maxHeight: CGFloat = 46,
        cornerRadius: CGFloat = 10.0,
        borderWidth: CGFloat = 0.0,
        font: Font = .bold(fixedSize: 16),
        isLoading: Bool = false
    ) -> some View {
        customButton(
            colorSet: ThemeManager.shared.colors.primaryButton,
            maxHeight: maxHeight,
            cornerRadius: cornerRadius,
            borderWidth: borderWidth,
            font: font,
            isLoading: isLoading
        )
    }

    /// Applies a secondary button style to the view.
    ///
    /// - Parameters:
    ///   - maxHeight: The maximum height of the button. Default is `46`.
    ///   - cornerRadius: The corner radius of the button. Default is `10`.
    ///   - borderWidth: The border width of the button. Default is `0`.
    ///   - isLoading: The loading state of the button. Default is `false`.
    /// - Returns: A view with the secondary button style applied.
    public func secondaryButton(
        maxHeight: CGFloat = 46,
        cornerRadius: CGFloat = 10.0,
        borderWidth: CGFloat = 0.0,
        font: Font = .bold(fixedSize: 16),
        isLoading: Bool = false
    ) -> some View {
        customButton(
            colorSet: ThemeManager.shared.colors.secondaryButton,
            maxHeight: maxHeight,
            cornerRadius: cornerRadius,
            borderWidth: borderWidth,
            font: font,
            isLoading: isLoading
        )
    }

    /// Applies a tertiary button style to the view.
    ///
    /// - Parameters:
    ///   - maxHeight: The maximum height of the button. Default is `46`.
    ///   - cornerRadius: The corner radius of the button. Default is `10`.
    ///   - borderWidth: The border width of the button. Default is `2`.
    ///   - isLoading: The loading state of the button. Default is `false`.
    /// - Returns: A view with the secondary button style applied.
    public func tertiaryButton(
        maxHeight: CGFloat = 46,
        cornerRadius: CGFloat = 10.0,
        borderWidth: CGFloat = 2.0,
        font: Font = .bold(fixedSize: 16),
        isLoading: Bool = false
    ) -> some View {
        customButton(
            colorSet: ThemeManager.shared.colors.tertiaryButton,
            maxHeight: maxHeight,
            cornerRadius: cornerRadius,
            borderWidth: borderWidth,
            font: font,
            isLoading: isLoading
        )
    }
}
