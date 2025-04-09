// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "O2UIToolkit",
  platforms: [
    .iOS(.v17)
  ],
  products: [
    .library(
      name: "O2UIToolkit",
      targets: ["O2UIToolkit"]
    ),
  ],
  targets: [
    .target(
      name: "O2UIToolkit",
      resources: [
        .copy("Theme/Resources/Colors/Colors.xcassets"),
        .process("Theme/Resources/FontResources")
      ]
    ),
    .testTarget(
      name: "O2UIToolkitTests",
      dependencies: ["O2UIToolkit"],
    ),
  ]
)
