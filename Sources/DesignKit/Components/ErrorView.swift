//
//  ErrorView.swift
//
//  Created by El Mostafa El Ouatri on 04/04/25.
//

import SwiftUI

/// A reusable error view that displays an icon, a message, and an optional retry button.
///
/// This view provides flexibility to customize the displayed icon, button text, and label content.
///
/// - Parameters:
///   - icon: An optional `Image` to be displayed above the message. Defaults to a system refresh icon.
///   - buttonText: An optional `String` for the button label. Defaults to a localized "Try Again" string.
///   - isButtonVisible: A `Bool` that determines whether the button is visible. Defaults to `true`.
///   - action: A closure executed when the button is tapped.
///   - label: A `ViewBuilder` closure that provides the message content. Defaults to a localized error message.
public struct ErrorView<Content: View>: View {
    // MARK: - Public Properties
    
    /// The icon displayed above the message.
    let icon: Image
    
    /// The text displayed on the retry button.
    let buttonText: String
    
    /// A boolean flag determining whether the retry button is visible.
    let isButtonVisible: Bool
    
    /// The closure executed when the retry button is tapped.
    let action: () -> Void
    
    /// A closure that returns the label content.
    let label: () -> Content
    
    /// Initializes an `ErrorView` with customizable properties.
    ///
    /// - Parameters:
    ///   - icon: An optional `Image` to be displayed above the message. Defaults to a system refresh icon.
    ///   - buttonText: An optional `String` for the button label. Defaults to a localized "Try Again" string.
    ///   - isButtonVisible: A `Bool` that determines whether the button is visible. Defaults to `true`.
    ///   - action: A closure executed when the button is tapped.
    ///   - label: A `ViewBuilder` closure that provides the message content. Defaults to a localized error message.
    public init(
        icon: Image? = nil,
        buttonText: String? = nil,
        isButtonVisible: Bool = true,
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Content = {
            Text(html: L10n.somethingWentWrong)
                .font(.regular(fixedSize: 16))
                .multilineTextAlignment(.center)
        }
    ) {
        self.buttonText = buttonText ?? L10n.tryAgain
        self.icon = icon ?? Image(systemName: "arrow.trianglehead.clockwise")
        self.isButtonVisible = isButtonVisible
        self.action = action
        self.label = label
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Spacer()
            
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                
            label()
                
            Spacer()
            
            if isButtonVisible {
                Button(buttonText, action: action)
                    .primaryButton()
            }
        }
        .foregroundColor(.darkGrayColor)
        .padding()
    }
}



struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView() {}
    }
}
