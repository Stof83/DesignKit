//
//  StepperButtonView.swift
//
//
//  Created by El Mostafa El Ouatri on 19/06/23.
//

import SwiftUI

/// A custom SwiftUI button view used for stepper-like increment or decrement actions.
///
/// The `StepperButtonView` is a button with an image that can be used for increment or decrement actions.
/// It is commonly used in stepper or counter-like interfaces where users can increase or decrease a value.
///
/// Example usage:
/// ```
/// let incrementButton = StepperButtonView(image: Image(systemName: "plus"), disabled: false) {
///     // Increment action
///     // Implement the logic to increase the value here
/// }
/// ```
///
/// - Note: The button's behavior (e.g., disabled state, action) is determined by the `disabled` and `action` properties.
public struct StepperButtonView: View {
    
    // MARK: - Public Properties
    
    /// The image to display in the button.
    public let image: Image
    
    /// A Boolean value indicating whether the button is disabled.
    public let disabled: Bool
    
    /// The size of button
    public let size: CGFloat
    
    /// The closure to be called when the button is tapped.
    public let action: () -> Void

    // MARK: - Initialize
    
    /// Initializes a new `StepperButtonView`.
    ///
    /// - Parameters:
    ///   - image: The image to display in the button.
    ///   - disabled: A Boolean value indicating whether the button is disabled.
    ///   - action: The closure to be called when the button is tapped.
    public init(image: Image, disabled: Bool, size: CGFloat = 50, action: @escaping () -> Void) {
        self.image = image
        self.disabled = disabled
        self.size = size
        self.action = action
    }
    
    // MARK: - Body
    
    /// The body of the button view, displaying the image inside a button.
    public var body: some View {
        Button(action: action) {
            image
                .resizable()
                .scaledToFit()
                .opacity(disabled ? Constants.Button.Opacity.disabled : 1)
        }
        .disabled(disabled)
        .frame(width: size, height: size)
    }
}

struct StepperButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StepperButtonView(image: .iconButtonPlus, disabled: false) {}
    }
}
