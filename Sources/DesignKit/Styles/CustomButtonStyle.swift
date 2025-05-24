//
//  CustomButtonStyle.swift
//
//
//  Created by El Mostafa El Ouatri on 06/08/23.
//

import SwiftUI

/// A custom `ButtonStyle` to style buttons with customizable background color, foreground color, corner radius, border width, and loading indicator.
///
/// The `CustomButtonStyle` modifies the appearance of a `Button` based on the provided configuration and environment properties. It supports customizing the button's background color, foreground color, corner radius, border width, and displaying a loading indicator when the `isLoading` property is `true`.
///
/// Example usage:
/// ```
/// Button("Submit") {
///     // Handle button tap
/// }
/// .buttonStyle(
///     .customButtonStyle(
///         backgroundColor: .blue,
///         foregroundColor: .white,
///         cornerRadius: 8,
///         borderWidth: 2,
///         isLoading: false
///     )
/// )
/// ```
public struct CustomButtonStyle: ButtonStyle {

    // MARK: - @Environment Properties

    /// The boolean value indicating whether the button is enabled.
    @Environment(\.isEnabled) private var isEnabled
    
    // MARK: - Public Properties

    /// The background color of the button.
    public var backgroundColor: Color

    /// The foreground color of the button.
    public var foregroundColor: Color

    /// The maximum height of the button.
    public var maxHeight: CGFloat

    /// The corner radius of the button.
    public var cornerRadius: CGFloat

    /// The border width of the button.
    public var borderWidth: CGFloat

    /// The border font of the button.
    public var font: Font

    /// A boolean value indicating whether the button is in a loading state.
    public var isLoading: Bool

    /// Modifies the appearance of the button based on the provided configuration.
    ///
    /// - Parameter configuration: The configuration of the button.
    /// - Returns: A view representing the modified appearance of the button.
    public func makeBody(configuration: Configuration) -> some View {

        // Calculate the background color based on the button's state (pressed or not) and isLoading.
        let buttonBackgroundColor = backgroundColor.opacity(
            configuration.isPressed && !isLoading ? Constants.Button.Opacity.pressed : 1
        )
        
        // Calculate the button's opacity based on its isEnabled state or isLoading state.
        let buttonOpacity = isEnabled || isLoading ? 1 : Constants.Button.Opacity.disabled
        
        // Create the button content (either the label or the loading indicator).
        let buttonContent: AnyView
                
        if isLoading {
            buttonContent = AnyView(
                SpinnerIndicatorView(color: foregroundColor)
                    .frame(maxHeight: maxHeight)
            )
        } else {
            buttonContent = AnyView(
                configuration.label
            )
        }
        
        // Apply the custom styling to the button.
        return buttonContent
            .textCase(.uppercase)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: maxHeight)
            .font(font)
            .background(buttonBackgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(cornerRadius)
            .opacity(buttonOpacity)
            .disabled(!isEnabled || isLoading)
            .borderStyle(
                width: borderWidth,
                color: foregroundColor,
                cornerRadius: cornerRadius
            )

    }
}

extension ButtonStyle where Self == CustomButtonStyle {
    /// Creates a custom button style with the specified appearance properties.
    ///
    /// Example usage:
    /// ```
    /// Button("Submit") {
    ///     // Handle button tap
    /// }
    /// .buttonStyle(
    ///     .customButtonStyle(
    ///         backgroundColor: .blue,
    ///         foregroundColor: .white,
    ///         cornerRadius: 8,
    ///         borderWidth: 2,
    ///         isLoading: false
    ///     )
    /// )
    /// ```
    ///
    /// - Parameters:
    ///   - backgroundColor: The background color of the button.
    ///   - foregroundColor: The foreground color of the button.
    ///   - maxHeight: The maximum height of the button. Default is `46`.
    ///   - cornerRadius: The corner radius of the button. Default is `0.0`.
    ///   - borderWidth: The border width of the button. Default is `0.0`.
    ///   - isLoading: A boolean value indicating whether the button is in a loading state. Default is `false`.
    /// - Returns: A custom button style with the specified appearance properties.
    public static func customButtonStyle(
        backgroundColor: Color = .clear,
        foregroundColor: Color = .black,
        maxHeight: CGFloat = 46,
        cornerRadius: CGFloat = 0.0,
        borderWidth: CGFloat = 0.0,
        font: Font = .bold(fixedSize: 16),
        isLoading: Bool = false
    ) -> CustomButtonStyle {
        CustomButtonStyle(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            maxHeight: maxHeight,
            cornerRadius: cornerRadius,
            borderWidth: borderWidth,
            font: font,
            isLoading: isLoading
        )
    }
}

