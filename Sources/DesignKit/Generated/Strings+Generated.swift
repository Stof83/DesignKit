// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Days
  public static let days = L10n.tr("Localizable", "days")
  /// Hours
  public static let hours = L10n.tr("Localizable", "hours")
  /// Minutes
  public static let minutes = L10n.tr("Localizable", "minutes")
  /// Seconds
  public static let seconds = L10n.tr("Localizable", "seconds")
  /// We’re sorry, but something went wrong.<br>Please, try again.
  public static let somethingWentWrong = L10n.tr("Localizable", "something_went_wrong")
  /// Try Again
  public static let tryAgain = L10n.tr("Localizable", "try_again")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
