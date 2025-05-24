//
//  RoundedTextFieldStyle.swift
//
//
//  Created by El Mostafa El Ouatri on 13/10/23.
//

import SwiftUI

/// A collection of custom `TextFieldStyle` implementations that provide different visual styles for SwiftUI `TextField` components.
///
/// - `OutlinedTextFieldStyle`: Adds an outlined border with an animated color change when focused.
/// - `RoundedTextFieldStyle`: Applies a rounded background that disappears when focused, replacing it with an outline.
/// - `UnderlineTextFieldStyle`: Adds an underline that animates with an overlay when focused.
/// - `IconTextFieldStyle`: Adds an icon next to the text field.
///
/// These styles enhance the default `TextField` UI by providing better visual feedback and customization.

/// A custom `TextFieldStyle` that adds an outlined border with an animated focus effect.
struct OutlinedTextFieldStyle: TextFieldStyle {
    var cornerRadius: CGFloat
    var color: Color
    var focusColor: Color
    var lineWidth: CGFloat
    var padding: CGFloat
    
    @FocusState private var isFocused: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(padding)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(isFocused ? focusColor : color, lineWidth: lineWidth)
                    .animation(.easeInOut(duration: 0.4), value: isFocused)
            )
            .focused($isFocused)
    }
}

/// A custom `TextFieldStyle` that applies a rounded background that disappears when focused, replacing it with an outline.
struct RoundedTextFieldStyle: TextFieldStyle {
    var background: Color
    var focusColor: Color
    var cornerRadius: CGFloat
    var lineWidth: CGFloat
    var padding: CGFloat
    
    @FocusState private var isFocused: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(padding)
            .background(
                Group {
                    isFocused ? Color.clear : background
                }.animation(.easeInOut(duration: 0.3), value: isFocused)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(isFocused ? focusColor : Color.clear, lineWidth: lineWidth)
                    .animation(.easeInOut(duration: 0.3), value: isFocused)
            )
            .focused($isFocused)
    }
}

/// A custom `TextFieldStyle` that adds an underline with an animated overlay when focused.
struct UnderlineTextFieldStyle: TextFieldStyle {
    var color: Color
    var focusColor: Color
    var height: CGFloat
    var spacing: CGFloat
    
    @FocusState private var isFocused: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, spacing)
            .background(
                VStack {
                    Spacer()
                    color
                        .frame(height: height)
                        .overlay {
                            if isFocused {
                                Rectangle()
                                    .frame(height: height) // Set the height of the line
                                    .foregroundColor(focusColor)
                                    .frame(height: height)
                                    .scaleEffect(x: isFocused ? 1 : 0, y: 1, anchor: .center)
                                    .animation(.easeInOut(duration: 1), value: isFocused)
                            }
                        }
                    
                }
            )
            .focused($isFocused)
    }
}

/// A custom `TextFieldStyle` that applies an icon to the text field.
struct IconTextFieldStyle: TextFieldStyle {
    var icon: Image?
    var alignment: VerticalAlignment
    var spacing: CGFloat
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(alignment: alignment, spacing: spacing) {
            icon
            configuration
        }
    }
}

extension View {
    /// Applies an outline style to the text field with the given properties.
    /// - Parameters:
    ///   - cornerRadius: The corner radius of the outline (default is 6).
    ///   - borderColor: The color of the border (default is `.gray`).
    ///   - focusColor: The color of the border when focused (default is `.blue`).
    ///   - lineWidth: The width of the border line (default is 1).
    ///   - padding: The padding inside the text field (default is `.init(top: 8, leading: 8, bottom: 8, trailing: 8)`).
    public func outline(
        cornerRadius: CGFloat = 10,
        borderColor: Color = .lightGray,
        focusColor: Color = .darkGrayColor,
        lineWidth: CGFloat = 1,
        padding: CGFloat = 10
    ) -> some View {
        self.textFieldStyle(OutlinedTextFieldStyle(
            cornerRadius: cornerRadius,
            color: borderColor,
            focusColor: focusColor,
            lineWidth: lineWidth,
            padding: padding
        ))
    }
    
    /// Applies a rounded style to the text field with the given properties.
    /// - Parameters:
    ///   - background: The background color of the text field (default is `.gray.opacity(0.2)`).
    ///   - focusColor: The color of the border when focused (default is `.blue`).
    ///   - cornerRadius: The corner radius of the text field (default is 10).
    ///   - lineWidth: The width of the border line (default is 1).
    ///   - padding: The padding inside the text field (default is `.init(top: 10, leading: 10, bottom: 10, trailing: 10)`).
    public func rounded(
        background: Color = .lightGray,
        focusColor: Color = .darkGrayColor,
        cornerRadius: CGFloat = 10,
        lineWidth: CGFloat = 1,
        padding: CGFloat = 10
    ) -> some View {
        self.textFieldStyle(RoundedTextFieldStyle(
            background: background,
            focusColor: focusColor,
            cornerRadius: cornerRadius,
            lineWidth: lineWidth,
            padding: padding
        ))
    }
    
    /// Applies an underlined style to the text field with the given properties.
    /// - Parameters:
    ///   - lineColor: The color of the underline (default is `.gray`).
    ///   - focusedLineColor: The color of the underline when focused (default is `.blue`).
    ///   - lineWidth: The thickness of the underline (default is 1).
    ///   - lineSpace: The space above the underline (default is 4).
    public func bottomline(
        lineColor: Color = .lightGray,
        focusColor: Color = .darkGrayColor,
        lineWidth: CGFloat = 1,
        lineSpace: CGFloat = 4
    ) -> some View {
        self.textFieldStyle(UnderlineTextFieldStyle(
            color: lineColor,
            focusColor: focusColor,
            height: lineWidth,
            spacing: lineSpace
        ))
    }
    
    /// Applies an icon style to the text field with the given properties.
    /// - Parameters:
    ///   - icon: The icon to display next to the text field (default is nil).
    ///   - alignment: The vertical alignment of the icon (default is `.center`).
    ///   - spacing: The spacing between the icon and the text field (default is 10).
    public func icon(
        _ icon: Image? = nil,
        alignment: VerticalAlignment = .center,
        spacing: CGFloat = 10
    ) -> some View {
        self.textFieldStyle(IconTextFieldStyle(icon: icon, alignment: alignment, spacing: spacing))
    }
}

struct TextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 50) {
            TextField("Outline", text: .constant(""))
                .outline()
            
            TextField("Rounded", text: .constant(""))
                .rounded()
                .foregroundColor(.red)
            
            TextField("Underline", text: .constant(""))
                .bottomline()
            
            TextField("Icon", text: .constant(""))
                .outline()
                .icon(Image(systemName: "magnifyingglass"))
        }
        .padding()
    }
}
