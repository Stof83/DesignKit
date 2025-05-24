# DesignKit

[![Swift Version](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Stof83/DesignKit/blob/main/LICENSE)

DesignKit provides a collection of view components, modifiers, and button styles to customize and manage the theme of your iOS app. It includes various theming utilities and color management through the `ThemeManager` struct and associated structs.

## Installation

You can install `DesignKit` using Swift Package Manager (SPM). Simply add the package as a dependency in your `Package.swift` file:

```swift
// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "YourPackageName",
    dependencies: [
        .package(url: "https://github.com/Stof83/DesignKit.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "YourTargetName",
            dependencies: [
                .product(name: "DesignKit", package: "DesignKit")
            ]
        )
    ]
)
```

## Components

### RemoteImageView
A view for displaying an image loaded from a URL.

Example usage:
```swift
RemoteImageView(url: "https://example.com/image.jpg")
```

### LottieView
A view that displays Lottie animations.

Example usage:
```swift
LottieView(.url(URL(string: "https://example.com/animation.json")!))
```

### CheckItemView
A view to represent a checkable item with an image and label.

Example usage:
```swift
CheckItemView(imageUrl: "https://example.com/icon.png", label: "Check Item", isSelected: true)
```

### ItemView
A view representing an item with an image and text.

Example usage:
```swift
ItemView(image: Image(systemName: "star.fill"), text: "Item 1")
```

### StepperView
A view representing a stepper control.

Example usage:
```swift
StepperView(value: $stepperValue, in: 0...10)
```

### WebView
A view for displaying a web page in a web view.

Example usage:
```swift
WebView(url: "https://example.com")
```

### WebViewLinkView
A view for displaying a hyperlink to a web view.

Example usage:
```swift
WebViewLinkView(text: "Visit Website", title: "Website", image: Image(systemName: "globe"), url: "https://example.com")
```

### MaterialLoadingIndicatorView
A view for displaying a Material-style loading indicator.

Example usage:
```swift
MaterialLoadingIndicatorView(color: .blue, lineWidth: 3)
```

### SpinnerIndicatorView
A view for displaying a custom spinner-style loading indicator.

Example usage:
```swift
SpinnerIndicatorView(color: .red)
```

## Modifiers

### BorderStyle
A modifier to add a border to a view.

Example usage:
```swift
Text("Border Style Example")
    .borderStyle(width: 2, color: .blue, cornerRadius: 8)
```

### IsHidden
A modifier to hide or show a view based on a boolean value.

Example usage:
```swift
Text("Hidden Text")
    .isHidden(true)
```

### ListItemStyle
A modifier to style a list item view with a border and background color.

Example usage:
```swift
Text("List Item")
    .listItemStyle(isSelected: true, height: 50)
```

### CustomButton
A modifier to create custom-styled buttons.

Example usage:
```swift
Button("Custom Button", action: { /* Button action */ })
    .customButton(
        colorSet: ColorSet(color: .blue, overlay: .white),
        maxHeight: 46,
        cornerRadius: 10,
        borderWidth: 2,
        isLoading: false
    )
```

## Button Styles

### CustomButtonStyle
A button style for creating custom-styled buttons with various customization options.

Example usage:
```swift
Button("Custom Button", action: { /* Button action */ })
    .buttonStyle(.customButtonStyle(
        backgroundColor: .blue,
        foregroundColor: .white,
        maxHeight: 46,
        cornerRadius: 10,
        borderWidth: 2,
        isLoading: false
    ))
```

## ThemeManager

The `ThemeManager` struct is a singleton that manages the theme colors for your iOS app. It includes the following components:

### ThemeManager
A struct that represents the theme manager SDK.

### ThemeColors
A struct containing the theme colors used in the app.

### ColorSet
A struct representing a set of colors with a base color and an overlay color.

Example usage:
```swift
// Customize theme colors and update the ThemeManager
let customColors = ThemeColors(
        brand: ColorSet(color: .blue, overlay: .white),
        primary: ColorSet(color: .green, overlay: .white),
        secondary: ColorSet(color: .purple, overlay: .white),
        primaryButton: ColorSet(color: .orange, overlay: .white),
        secondaryButton: ColorSet(color: .gray, overlay: .white)
)

ThemeManager.shared.set(colors: customColors)
```

## Compatibility

This SDK is compatible with SwiftUI-based iOS apps and requires iOS 14 or later.

## License

This SDK is provided under the MIT License. [See LICENSE](https://github.com/Stof83/DesignKit/blob/main/LICENSE) for details.
Feel free to use, modify, and distribute it as per the terms of the license.
