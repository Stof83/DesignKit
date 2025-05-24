//
//  MaterialLoadingIndicatorView.swift
//
//
//  Created by El Mostafa El Ouatri on 22/06/23.
//

import MHLoadingButton
import SwiftUI
import UIKit

/// A SwiftUI view that wraps the `MaterialLoadingIndicator` provided by the `MHLoadingButton` framework.
///
/// The `MaterialLoadingIndicatorView` displays a loading indicator that animates while a task is being processed.
/// It is designed to be used as a loading view for asynchronous operations.
///
/// Example usage:
/// ```
/// let loadingView = MaterialLoadingIndicatorView(color: .blue, lineWidth: 2.0)
/// ```
public struct MaterialLoadingIndicatorView: UIViewRepresentable {
    // MARK: - Public Properties
    
    /// The color of the loading indicator.
    public var color: UIColor
    
    /// The width of the loading indicator line.
    public var lineWidth: CGFloat
    
    // MARK: - Initialize
    
    /// Initializes a new `MaterialLoadingIndicatorView`.
    ///
    /// - Parameters:
    ///   - color: The color of the loading indicator.
    ///   - lineWidth: The width of the loading indicator line.
    public init(color: UIColor, lineWidth: CGFloat) {
        self.color = color
        self.lineWidth = lineWidth
    }
    
    // MARK: - UIViewRepresentable
    
    /// Creates and configures the underlying UIKit view for the `MaterialLoadingIndicator`.
    public func makeUIView(context: Context) -> MaterialLoadingIndicator {
        let loadingIndicator = MaterialLoadingIndicator()
        loadingIndicator.color = color
        loadingIndicator.lineWidth = lineWidth
        loadingIndicator.startAnimating()
        return loadingIndicator
    }
    
    /// Updates the view represented by this object.
    public func updateUIView(_ uiView: MaterialLoadingIndicator, context: Context) {
        uiView.color = color
        uiView.lineWidth = lineWidth
    }
}


