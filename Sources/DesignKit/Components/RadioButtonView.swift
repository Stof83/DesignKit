//
//  SwiftUIView.swift
//
//  Created by El Mostafa El Ouatri on 28/02/25.
//

import SwiftUI

struct AnimationProperties {
    var scaleValue: CGFloat = 1.0
}

/// A customizable radio button view that supports custom content.
///
/// - Uses `@ViewBuilder` to allow flexible content.
/// - Supports both `Bool` binding and `Hashable` selection.
public struct RadioButtonView<Content: View>: View {
    @Binding private var isSelected: Bool
    @State private var scale: CGFloat = 1.0

    private let content: () -> Content
    private var isDisabled: Bool = false

    /// Initializes a radio button with a boolean binding.
    ///
    /// - Parameters:
    ///   - isSelected: A binding to determine selection state.
    ///   - content: A view builder for custom content.
    public init(isSelected: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._isSelected = isSelected
        self.content = content
    }
    
    /// Initializes a radio button with a selection binding.
    ///
    /// - Parameters:
    ///   - tag: A value representing this radio button.
    ///   - selection: A binding to the selected value.
    ///   - content: A view builder for custom content.
    public init<V: Hashable>(tag: V, selection: Binding<V?>, @ViewBuilder content: @escaping () -> Content) {
        self._isSelected = Binding(
            get: { selection.wrappedValue == tag },
            set: { _ in selection.wrappedValue = tag }
        )
        self.content = content
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 16) {
            circleView
            content()
                .opacity(isDisabled ? 0.6 : 1)
        }
        .onTapGesture { isSelected = true }
        .disabled(isDisabled)
    }
}

private extension RadioButtonView {
    /// The circular selection indicator.
    var circleView: some View {
        Circle()
            .fill(innerCircleColor)
            .padding(4)
            .overlay(
                Circle()
                    .stroke(outlineColor, lineWidth: 1)
            )
            .frame(width: 20, height: 20)
            .scaleEffect(scale)
            .onChange(of: isSelected, perform: handleSelectionChange)
    }
    
    /// Handles selection animations.
    func handleSelectionChange(_ newValue: Bool) {
        if newValue {
            withAnimation(.easeInOut(duration: 0.05)) { scale = 0.9 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation(.easeInOut(duration: 0.15)) { scale = 1.10 }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.easeInOut(duration: 0.25)) { scale = 1.0 }
                }
            }
        }
    }
}

private extension RadioButtonView {
    /// The color of the inner circle based on selection and disabled state.
    var innerCircleColor: Color {
        isDisabled ? Color.gray.opacity(0.6) : (isSelected ? Color.darkGrayColor : Color.clear)
    }
    
    /// The color of the outer circle stroke.
    var outlineColor: Color {
        isDisabled ? Color.gray.opacity(0.6) : (isSelected ? Color.darkGrayColor : Color.gray)
    }
}

extension RadioButtonView {
    /// Disables user interaction.
    ///
    /// - Parameter value: A Boolean indicating whether the view is disabled.
    /// - Returns: A modified `RadioButtonView` with disabled state.
    public func disabled(_ value: Bool) -> Self {
        var view = self
        view.isDisabled = value
        return view
    }
}

struct RadioButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonView(isSelected: .constant(true)) {
            Text("Radio button view")
                .font(.regular(fixedSize: 14))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.darkGrayColor)
        }
        .disabled(true)
    }
}
