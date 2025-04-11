import SwiftUI
import UIKit

extension UIFont {
  enum FontVariations: UInt32 {
    case weight = 0x77676874
    case opticalSize = 0x6F70737A
  }

  static func fromSwiftUIFont(
    font: Font,
    name: String,
    configuration: O2FontStyle.Configuration
  ) -> UIFont {
    let axis: [FontVariations: CGFloat] = [
      .weight: configuration.weight,
      .opticalSize: configuration.size
    ]
    var variationAttributes: [CFString: Any] = [:]

    if !axis.isEmpty {
      let variations: [CFNumber: CFNumber] = axis.reduce(into: [:]) { result, entry in
        let key = NSNumber(value: entry.key.rawValue)
        let value = NSNumber(value: Double(entry.value))
        result[key] = value
      }

      variationAttributes[kCTFontVariationAttribute] = variations
    }

    var descriptor = UIFontDescriptor(name: name, size: configuration.size)

    if !variationAttributes.isEmpty {
      descriptor = descriptor.addingAttributes(
        variationAttributes as [UIFontDescriptor.AttributeName: Any]
      )
    }

    return UIFont(descriptor: descriptor, size: configuration.size)
  }

  static func fromInterVariable(configuration: O2FontStyle.Configuration) -> UIFont {
    return fromSwiftUIFont(
      font: Font.system(size: configuration.size),
      name: "Inter",
      configuration: configuration
    )
  }
}
