// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.UFont", message: "This typealias will be removed in SwiftGen 7.0")
public typealias UFont = FontConvertible.UFont

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum FontFamily {
  public enum OpenSans {
    public static let regular = FontConvertible(name: "OpenSans", family: "Open Sans", path: "OpenSans.ttf")
    public static let bold = FontConvertible(name: "OpenSans-Bold", family: "Open Sans", path: "OpenSans-Bold.ttf")
    public static let boldItalic = FontConvertible(name: "OpenSans-BoldItalic", family: "Open Sans", path: "OpenSans-BoldItalic.ttf")
    public static let extrabold = FontConvertible(name: "OpenSans-Extrabold", family: "Open Sans", path: "OpenSans-ExtraBold.ttf")
    public static let extraboldItalic = FontConvertible(name: "OpenSans-ExtraboldItalic", family: "Open Sans", path: "OpenSans-ExtraBoldItalic.ttf")
    public static let italic = FontConvertible(name: "OpenSans-Italic", family: "Open Sans", path: "OpenSans-Italic.ttf")
    public static let light = FontConvertible(name: "OpenSans-Light", family: "Open Sans", path: "OpenSans-Light.ttf")
    public static let semibold = FontConvertible(name: "OpenSans-Semibold", family: "Open Sans", path: "OpenSans-Semibold.ttf")
    public static let semiboldItalic = FontConvertible(name: "OpenSans-SemiboldItalic", family: "Open Sans", path: "OpenSans-SemiboldItalic.ttf")
    public static let lightItalic = FontConvertible(name: "OpenSansLight-Italic", family: "Open Sans", path: "OpenSans-LightItalic.ttf")
    public static let all: [FontConvertible] = [regular, bold, boldItalic, extrabold, extraboldItalic, italic, light, semibold, semiboldItalic, lightItalic]
  }
  public static let allCustomFonts: [FontConvertible] = [OpenSans.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct FontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(macOS)
  public typealias UFont = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias UFont = UIFont
  #endif

  public func font(size: CGFloat) -> UFont {
    guard let font = UFont(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

public extension FontConvertible.UFont {
  convenience init?(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(macOS)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type


extension Font {
    public static func openSans(_ style: OpenSansFontStyle, fixedSize: CGFloat) -> Font {
        Font.custom(style.rawValue, fixedSize: fixedSize)
    }

    public static func openSans(_ style: OpenSansFontStyle, size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        Font.custom(style.rawValue, size: size, relativeTo: textStyle)
    }

    public static func regular(fixedSize: CGFloat) -> Font {
        .openSans(.regular, fixedSize: fixedSize)
    }

    public static func regular(size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        .openSans(.regular, size: size, relativeTo: textStyle)
    }

    public static func bold(fixedSize: CGFloat) -> Font {
        .openSans(.bold, fixedSize: fixedSize)
    }

    public static func bold(size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        .openSans(.bold, size: size, relativeTo: textStyle)
    }

    public static func boldItalic(fixedSize: CGFloat) -> Font {
        .openSans(.boldItalic, fixedSize: fixedSize)
    }

    public static func boldItalic(size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        .openSans(.boldItalic, size: size, relativeTo: textStyle)
    }

    public static func extrabold(fixedSize: CGFloat) -> Font {
        .openSans(.extrabold, fixedSize: fixedSize)
    }

    public static func extrabold(size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        .openSans(.extrabold, size: size, relativeTo: textStyle)
    }

    public static func extraboldItalic(fixedSize: CGFloat) -> Font {
        .openSans(.extraboldItalic, fixedSize: fixedSize)
    }

    public static func extraboldItalic(size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        .openSans(.extraboldItalic, size: size, relativeTo: textStyle)
    }

    public static func italic(fixedSize: CGFloat) -> Font {
        .openSans(.italic, fixedSize: fixedSize)
    }

    public static func italic(size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        .openSans(.italic, size: size, relativeTo: textStyle)
    }

    public static func light(fixedSize: CGFloat) -> Font {
        .openSans(.light, fixedSize: fixedSize)
    }

    public static func light(size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        .openSans(.light, size: size, relativeTo: textStyle)
    }

    public static func semibold(fixedSize: CGFloat) -> Font {
        .openSans(.semibold, fixedSize: fixedSize)
    }

    public static func semibold(size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        .openSans(.semibold, size: size, relativeTo: textStyle)
    }

    public static func semiboldItalic(fixedSize: CGFloat) -> Font {
        .openSans(.semiboldItalic, fixedSize: fixedSize)
    }

    public static func semiboldItalic(size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        .openSans(.semiboldItalic, size: size, relativeTo: textStyle)
    }

    public static func lightItalic(fixedSize: CGFloat) -> Font {
        .openSans(.lightItalic, fixedSize: fixedSize)
    }

    public static func lightItalic(size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        .openSans(.lightItalic, size: size, relativeTo: textStyle)
    }

    public enum OpenSansFontStyle: String {
        case regular = "OpenSans"
        case bold = "OpenSans-Bold"
        case boldItalic = "OpenSans-BoldItalic"
        case extrabold = "OpenSans-Extrabold"
        case extraboldItalic = "OpenSans-ExtraboldItalic"
        case italic = "OpenSans-Italic"
        case light = "OpenSans-Light"
        case semibold = "OpenSans-Semibold"
        case semiboldItalic = "OpenSans-SemiboldItalic"
        case lightItalic = "OpenSansLight-Italic"
    }
}

extension UIFont {
    public static func openSans(_ style: OpenSansFontStyle, fixedSize: CGFloat) -> UIFont {
        let font = FontConvertible(name: style.rawValue, family: "Open Sans", path: "\(style.rawValue).ttf")
        return UIFont(font: font, size: fixedSize) ?? UIFont.systemFont(ofSize: fixedSize)
    }

    public static func regular(fixedSize: CGFloat) -> UIFont {
        .openSans(.regular, fixedSize: fixedSize)
    }

    public static func bold(fixedSize: CGFloat) -> UIFont {
        .openSans(.bold, fixedSize: fixedSize)
    }

    public static func boldItalic(fixedSize: CGFloat) -> UIFont {
        .openSans(.boldItalic, fixedSize: fixedSize)
    }

    public static func extrabold(fixedSize: CGFloat) -> UIFont {
        .openSans(.extrabold, fixedSize: fixedSize)
    }

    public static func extraboldItalic(fixedSize: CGFloat) -> UIFont {
        .openSans(.extraboldItalic, fixedSize: fixedSize)
    }

    public static func italic(fixedSize: CGFloat) -> UIFont {
        .openSans(.italic, fixedSize: fixedSize)
    }

    public static func light(fixedSize: CGFloat) -> UIFont {
        .openSans(.light, fixedSize: fixedSize)
    }

    public static func semibold(fixedSize: CGFloat) -> UIFont {
        .openSans(.semibold, fixedSize: fixedSize)
    }

    public static func semiboldItalic(fixedSize: CGFloat) -> UIFont {
        .openSans(.semiboldItalic, fixedSize: fixedSize)
    }

    public static func lightItalic(fixedSize: CGFloat) -> UIFont {
        .openSans(.lightItalic, fixedSize: fixedSize)
    }


    public enum OpenSansFontStyle: String {
        case regular = "OpenSans"
        case bold = "OpenSans-Bold"
        case boldItalic = "OpenSans-BoldItalic"
        case extrabold = "OpenSans-Extrabold"
        case extraboldItalic = "OpenSans-ExtraboldItalic"
        case italic = "OpenSans-Italic"
        case light = "OpenSans-Light"
        case semibold = "OpenSans-Semibold"
        case semiboldItalic = "OpenSans-SemiboldItalic"
        case lightItalic = "OpenSansLight-Italic"
    }
}
