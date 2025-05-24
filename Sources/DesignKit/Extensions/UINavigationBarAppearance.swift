//
//  UINavigationBarAppearance.swift
//  DesignKit
//
//  Created by El Mostafa El Ouatri on 13/03/25.
//

import UIKit
import SwiftUI

extension UINavigationBarAppearance {
    public func setColor(foregroundColor: UIColor? = nil, backgroundColor: UIColor? = nil, backIndicatorImage: UIImage? = .iconBackPrimary) {
        configureWithTransparentBackground()
        if let foregroundColor {
            largeTitleTextAttributes = [
                .font: UIFont.bold(fixedSize: 40),
                .foregroundColor: foregroundColor
            ]
            titleTextAttributes = [
                .font: UIFont.bold(fixedSize: 20),
                .foregroundColor: foregroundColor
            ]
        }
        
        UIColor.navigationBarForegroundColor = foregroundColor ?? .darkGrayColor
        Color.navigationBarForegroundColor = Color(.navigationBarForegroundColor)
        
        self.backgroundColor = backgroundColor
        
        UINavigationBar.appearance().scrollEdgeAppearance = self
        UINavigationBar.appearance().standardAppearance = self
        
        if let backIndicatorImage {
            let tintedImage = backIndicatorImage.withRenderingMode(.alwaysTemplate)
            UINavigationBar.appearance().backIndicatorImage = tintedImage
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = tintedImage
            UINavigationBar.appearance().tintColor = foregroundColor ?? .darkGrayColor
        }

    }
    
    public func setDarkTheme() {
        setColor(
            foregroundColor: .white,
            backgroundColor: .darkGrayColor
        )
    }

    public func setWhiteTheme() {
        setColor(
            foregroundColor: .darkGrayColor,
            backgroundColor: .white
        )
    }
}

extension UIColor {
    static public var navigationBarForegroundColor: UIColor = .darkGrayColor
}

extension Color {
    static public var navigationBarForegroundColor: Color = .darkGrayColor
}

