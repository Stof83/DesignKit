//
//  ItemView.swift
//  
//
//  Created by El Mostafa El Ouatri on 18/06/23.
//

import SwiftUI

/// Enum to specify the position of dividers in `ItemView`.
public enum DividerPosition {
    case top
    case bottom
}

/// A custom SwiftUI view representing an item with an image and text, commonly used in lists and tables.
///
/// The `ItemView` displays an image, a text label, and a disclosure indicator icon, arranged in a horizontal stack.
/// It is designed to be used in lists or tables to represent individual items with associated content.
///
/// Example usage:
/// ```
/// let itemView = ItemView(image: Image("exampleImage"), text: "Example Item")
/// ```
public struct ItemView: View {
    // MARK: - Public Properties
    
    /// The image to display in the item view.
    public let image: Image
    
    /// The text label to display in the item view.
    public let text: String

    /// The optional text color. If provided, it will be used; otherwise, the primary color will be used.
    public let textColor: Color?
    
    /// The position of the divider in the `ItemView`. If nil, both top and bottom dividers are shown.
    public let divider: DividerPosition?

    // MARK: - Private Properties
    
    /// The primary color used for the text and disclosure indicator.
    private let primaryColor = ThemeManager.shared.colors.primary.color
    
    // MARK: - Initialize
    
    /// Initializes a new `ItemView`.
    ///
    /// - Parameters:
    ///   - image: The image to display in the item view.
    ///   - text: The text label to display in the item view.
    public init(
        image: Image,
        text: String,
        textColor: Color? = nil,
        divider: DividerPosition? = nil
    ) {
        self.image = image
        self.text = text
        self.textColor = textColor
        self.divider = divider
    }
    
    // MARK: - Body
    
    /// The body of the item view, displaying the image, text, and disclosure indicator.
    public var body: some View {
        VStack {
            
            if divider.isNil || divider == .top {
                Divider()
            }
            
            HStack {
                image
                    .frame(width: 28, height: 28)
                
                Text(text)
                    .font(.semibold(fixedSize: 14))
                    .foregroundColor(textColor ?? primaryColor)
                
                Spacer()
                
                Image.iconDisclosure
                    .font(.system(size: 20))
                    .foregroundColor(textColor ?? primaryColor)
            }
            .padding(.vertical, 2)

            if divider.isNil || divider == .bottom {
                Divider()
            }

        }
    }
}


struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(image: .iconBus, text: "Calcola percorso")
    }
}
