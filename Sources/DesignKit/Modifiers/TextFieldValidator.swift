//
//  TextFieldValidator.swift
//  DesignKit
//
//  Created by El Mostafa El Ouatri on 26/02/25.
//

import SwiftUI
import UtilitiesKit

/// A custom view modifier that applies validation logic to a `TextField`.
struct TextFieldValidatorModifier: ViewModifier {
    /// The text field's input value.
    @Binding var text: String
    
    /// The list of validation types to be applied to the field value.
    var validators: [ValidatorType]

    /// A binding to a Boolean value indicating whether the input is valid.
    /// This value will be updated based on the validation results.
    @Binding var isValid: Bool

    /// Modifies the `TextField` view to include validation logic.
    /// It listens for changes in the text and updates the validity state accordingly.
    func body(content: Content) -> some View {
        content
            .onChange(of: text) { newValue in
                isValid = validators.allSatisfy { $0.validate(newValue) }
            }
    }
}

extension View {
    /// A custom modifier to apply validation checks to a `TextField`.
    ///
    /// - Parameters:
    ///   - text: A binding to the `TextField`'s text value.
    ///   - validations: An array of `ValidationType` rules to apply.
    ///   - isValid: A binding to a Boolean value that tracks whether the input is valid.
    ///
    /// - Returns: A modified `TextField` view with the validation logic applied.
    public func validate(
        text: Binding<String>,
        validators: [ValidatorType],
        isValid: Binding<Bool>
    ) -> some View {
        modifier(TextFieldValidatorModifier(text: text, validators: validators, isValid: isValid))
    }
}

