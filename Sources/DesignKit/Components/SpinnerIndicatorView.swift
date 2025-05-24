//
//  SpinnerIndicatorView.swift
//
//
//  Created by El Mostafa El Ouatri on 20/06/23.
//

import SwiftUI
import UIKit

/// A SwiftUI view that displays a spinner/loading indicator using `MaterialLoadingIndicatorView`.
///
/// The `SpinnerIndicatorView` provides a simple way to display a loading indicator with a spinner animation.
/// It is designed to be used as a loading view for asynchronous operations or whenever a spinner is needed.
///
/// Example usage:
/// ```
/// let spinnerView = SpinnerIndicatorView(color: .blue)
/// ```
public struct SpinnerIndicatorView: View {
    /// The color of the spinner.
    public var color: Color
    
    /// Initializes the spinner view with the given color.
    ///
    /// - Parameter color: The color of the spinner. Defaults to the primary color from the app's theme.
    public init(color: Color = ThemeManager.shared.colors.primary.color) {
        self.color = color
    }
    
    /// The body of the spinner view, displaying the `MaterialLoadingIndicatorView`.
    public var body: some View {
        MaterialLoadingIndicatorView(color: color.toUIColor, lineWidth: 3)
    }

}

struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerIndicatorView()
    }
}
