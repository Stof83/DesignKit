// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignKit",
    platforms: [
        .iOS(.v15), .macOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "DesignKit", targets: ["DesignKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Stof83/UtilitiesKit.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/twho/loading-buttons-ios.git", .upToNextMajor(from: "0.1.3")),
        .package(url: "https://github.com/ArtSabintsev/FontBlaster.git", .upToNextMajor(from: "5.3.0")),
        .package(url: "https://github.com/airbnb/lottie-ios", .upToNextMajor(from: "4.3.3")),
        .package(url: "https://github.com/CSolanaM/SkeletonUI.git", .upToNextMajor(from: "2.0.2")),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", .upToNextMajor(from: "3.0.4")),
        .package(url: "https://github.com/Mijick/Popups.git", .upToNextMajor(from: "4.0.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DesignKit",
            dependencies: [
                .product(name: "UtilitiesKit", package: "UtilitiesKit"),
                .product(name: "MHLoadingButton", package: "loading-buttons-ios"),
                .product(name: "FontBlaster", package: "FontBlaster"),
                .product(name: "Lottie", package: "lottie-ios"),
                .product(name: "SkeletonUI", package: "SkeletonUI"),
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
                .product(name: "MijickPopups", package: "Popups"),
            ],
            resources: [
              .process("Resources")
            ],
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath(".")
            ]
        ),
    ]
)
