//
//  StepperView.swift
//
//
//  Created by El Mostafa El Ouatri on 19/06/23.
//

import SwiftUI

/// A custom SwiftUI view representing a stepper for incrementing or decrementing an integer value within a specified range.
///
/// The `StepperView` provides a user-friendly way to increment or decrement an integer value within a given range.
/// It is commonly used in scenarios where users need to select a numerical value from a specific range, like quantity selectors.
///
/// Example usage:
/// ```
/// @State var quantity = 1
/// let stepperView = StepperView(value: $quantity, in: 1...10)
/// ```
///
/// - Note: The `StepperView` relies on the `StepperButtonView` for the increment and decrement buttons.
///   The `value` property is bound to an external source (e.g., `@State` variable), and it is modified when the buttons are tapped.
///   The valid range of the stepper is determined by the `range` property.
public struct StepperView: View {
    
    // MARK: - @Binding Properties
    
    /// The binding to the integer value to display and modify.
    @Binding var value: Int
    
    // MARK: - Public Properties
    
    /// The closed range representing the valid values for the stepper.
    public let range: ClosedRange<Int>
    
    /// The size of button
    public let size: CGFloat
    
    // MARK: - Initialize
    
    /// Initializes a new `StepperView`.
    ///
    /// - Parameters:
    ///   - value: The binding to the integer value to display and modify.
    ///   - range: The closed range representing the valid values for the stepper.
    public init(value: Binding<Int>, in range: ClosedRange<Int>, size: CGFloat = 50) {
        _value = value
        self.range = range
        self.size = size
    }

    // MARK: - Body
    
    /// The body of the stepper view, displaying the increment and decrement buttons along with the current value.
    public var body: some View {
        HStack {
            Spacer()
            StepperButtonView(image: .iconButtonMinus, disabled: value == range.lowerBound, size: size) {
                if value > range.lowerBound { value -= 1 }
            }
            
            Text("\(value)")
                .font(.bold(fixedSize: 30))
                .frame(width: 80)
            
            StepperButtonView(image: .iconButtonPlus, disabled: value == range.upperBound, size: size) {
                if value < range.upperBound { value += 1 }
            }
            Spacer()
        }
    }

}


struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(value: .constant(0), in: 1...16)
    }
}
