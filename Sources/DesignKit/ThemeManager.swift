//
//  ThemeManager.swift
//
//
//  Created by El Mostafa El Ouatri on 16/06/23.
//

import Foundation
import FontBlaster
import SwiftUI
import UIKit

/// The ThemeManager struct represents the theme manager SDK.
public struct ThemeManager {
    
    /// The shared instance of the ThemeManager.
    public static var shared = ThemeManager()
    
    /// The colors used in the theme.
    public var colors = ThemeColors()
    
    /// Initializes a new instance of ThemeManager.
    public init() {
        // Initialize the ThemeManager with the default colors.
        FontBlaster.blast(bundle: .module)
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = colors.primary.color.toUIColor
    }
    
    /// Set the specified theme colors.
    ///
    /// - Parameter colors: The colors used in the theme.
    public mutating func set(colors: ThemeColors) {
        self.colors = colors
    }
}

/// The struct containing theme colors.
public struct ThemeColors {
    
    /// The accent color used for branding elements.
    public var brand: ColorSet
    
    /// The primary accent color.
    public var primary: ColorSet
    
    /// The secondary accent color.
    public var secondary: ColorSet
    
    /// The color for primary buttons.
    public var primaryButton: ColorSet
    
    /// The color for secondary buttons.
    public var secondaryButton: ColorSet
    
    /// The color for tertiary buttons.
    public var tertiaryButton: ColorSet
    
    /// Initializes a new instance of ThemeColors with default colors.
    public init() {
        brand = ColorSet(color: .brand, overlay: .brandOverlay)
        primary = ColorSet(color: .primary, overlay: .primaryOverlay)
        secondary = ColorSet(color: .secondary, overlay: .secondaryOverlay)
        primaryButton = ColorSet(color: .primaryButton, overlay: .primaryButtonText)
        secondaryButton = ColorSet(color: .secondaryButton, overlay: .secondaryButtonText)
        tertiaryButton = ColorSet(color: .tertiaryButton, overlay: .tertiaryButtonText)
    }
    
    /**
     Initializes a new ThemeColors instance with specified color sets for different UI elements.
     
     - Parameters:
        - brand: Color set for the brand elements.
        - primary: Color set for primary UI elements.
        - secondary: Color set for secondary UI elements.
        - primaryButton: Color set for primary button UI elements.
        - secondaryButton: Color set for secondary button UI elements.
     */
    public init(brand: ColorSet, primary: ColorSet, secondary: ColorSet, primaryButton: ColorSet, secondaryButton: ColorSet, tertiaryButton: ColorSet) {
        self.brand = brand
        self.primary = primary
        self.secondary = secondary
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        self.tertiaryButton = tertiaryButton
    }

}

/// A set of colors used for theming user interfaces in an iOS app.
public struct ColorSet {
    /// The base color used as the primary color.
    public var color: Color
    
    /// The overlay color used to add additional effects to the base color.
    public var overlay: Color
    
    /// Initializes a new instance of ColorSet with the specified colors.
    ///
    /// - Parameters:
    ///   - color: The base color used as the primary color.
    ///   - overlay: The overlay color used to add additional effects to the base color.
    public init(color: Color, overlay: Color) {
        self.color = color
        self.overlay = overlay
    }
}

