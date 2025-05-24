//
//  CheckItemView.swift
//
//  Created by El Mostafa El Ouatri on 14/06/23.
//

import SwiftUI

/// A custom view to display a check item with an image, label, and optional checkmark icon.
///
/// This view is used to represent items in a checklist with an associated image and label.
///
/// Example usage:
/// ```
/// let checkItem = CheckItemView(imageUrl: "exampleImageUrl",
///                               label: "Example Label",
///                               isSelected: true)
/// ```
///
/// - Note: The `RemoteImageView` component is used to load the image from the provided URL.
///
/// - SeeAlso: `RemoteImageView`
public struct CheckItemView: View {
    
    /// The URL string to load the image for the check item.
    public var imageUrl: String
    
    /// The label to display for the check item.
    public var label: String
    
    /// The size of the label to display for the check item.
    public var labelSize: CGFloat
    
    /// A Boolean value that indicates whether the check item is selected.
    public var isSelected: Bool
    
    /// The colors manager to access the app's theme colors.
    let colors = ThemeManager.shared.colors
    
    /// Initializes a new CheckItemView.
    ///
    /// - Parameters:
    ///   - imageUrl: The URL string to load the image for the check item.
    ///   - label: The label to display for the check item.
    ///   - isSelected: A Boolean value that indicates whether the check item is selected.
    public init(imageUrl: String, label: String, labelSize: CGFloat = 20, isSelected: Bool) {
        self.imageUrl = imageUrl
        self.label = label
        self.labelSize = labelSize
        self.isSelected = isSelected
    }
    
    /// The body of the check item view.
    public var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: imageUrl.toURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .foregroundColor(.skeletonView)
                        .defaultSkeleton(
                            with: true,
                            size: CGSize(width: 50, height: 50),
                            shape: .rounded(.radius(10, style: .circular))
                        )
                }
            }
            .frame(width: 50, height: 50)


            Text(label)
                .font(.semibold(fixedSize: labelSize))
                .foregroundColor(colors.primary.color)
            
            Spacer()
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(colors.brand.color)
            }
        }
        .listItemStyle(isSelected: isSelected, height: 59)
    }
}
