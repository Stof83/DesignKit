//
//  CheckBoxView.swift
//
//  Created by El Mostafa El Ouatri on 28/02/25.
//

import SwiftUI

/// A customizable checkbox button view that supports custom content and multiple selections.
///
/// - Supports both `Bool` binding and `Set<Hashable>` selection.
/// - Provides customizable font and disabled state.
public struct CheckboxButtonView<Content: View>: View {
    @Binding private var isSelected: Bool
    private let content: () -> Content
    private var isDisabled: Bool = false
    
    /// Initializes a checkbox with a boolean binding.
    ///
    /// - Parameters:
    ///   - isSelected: A binding to determine selection state.
    ///   - content: A view builder for custom content.
    public init(isSelected: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._isSelected = isSelected
        self.content = content
    }
    
    /// Initializes a checkbox with a selection binding.
    ///
    /// - Parameters:
    ///   - tag: A value representing this checkbox.
    ///   - selection: A binding to the selected set of values.
    ///   - content: A view builder for custom content.
    public init<V: Hashable>(tag: V, selection: Binding<Set<V>>, @ViewBuilder content: @escaping () -> Content) {
        self._isSelected = Binding(
            get: { selection.wrappedValue.contains(tag) },
            set: { _ in
                if selection.wrappedValue.contains(tag) {
                    selection.wrappedValue.remove(tag)
                } else {
                    selection.wrappedValue.insert(tag)
                }
            }
        )
        self.content = content
    }
    
    /// The color of the checkbox interior based on selection and disabled state.
    private var innerBoxColor: Color {
        guard isSelected else { return .clear }
        return isDisabled ? .darkGrayColor.opacity(0.6) : .darkGrayColor
    }
    
    /// The color of the checkbox outline.
    private var outlineColor: Color {
        return isDisabled ? .darkGrayColor.opacity(0.6) : .darkGrayColor
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 10) {
            boxView
            content()
                .opacity(isDisabled ? 0.6 : 1)
        }
        .onTapGesture { isSelected.toggle() }
        .disabled(isDisabled)
    }
    
    /// The checkbox view representing selection state.
    @ViewBuilder
    var boxView: some View {
        Rectangle()
            .fill(innerBoxColor)
            .animation(.easeInOut(duration: 0.15), value: isSelected)
            .padding(4)
            .overlay(
                Rectangle()
                    .stroke(outlineColor, lineWidth: 1)
            )
            .frame(width: 20, height: 20)
    }
}

extension CheckboxButtonView {
    /// Disables user interaction.
    ///
    /// - Parameter value: A Boolean indicating whether the view is disabled.
    /// - Returns: A modified `CheckboxButtonView` with disabled state.
    public func disabled(_ value: Bool) -> Self {
        var view = self
        view.isDisabled = value
        return view
    }
}

struct CheckboxButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxButtonView(isSelected: .constant(true)) {
            Text("Checkbox button view")
                .font(.regular(fixedSize: 14))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.darkGrayColor)
        }
    }
}
