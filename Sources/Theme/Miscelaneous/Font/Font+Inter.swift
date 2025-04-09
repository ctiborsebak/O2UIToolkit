import SwiftUI

extension Font {
  enum FontVariations: UInt32 {
    case weight = 0x77676874
    case opticalSize = 0x6F70737A
  }

  static func customFont(
    name: String,
    configuration: O2FontStyle.Configuration
  ) -> Font {
    let fontFamilyName = name.components(separatedBy: "-").first ?? name

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

    var descriptor = UIFontDescriptor(name: fontFamilyName, size: configuration.size)

    if !variationAttributes.isEmpty {
      descriptor = descriptor.addingAttributes(
        variationAttributes as [UIFontDescriptor.AttributeName: Any]
      )
    }

    let uiFont = UIFont(descriptor: descriptor, size: configuration.size)
    return Font(uiFont)
  }
}

extension Font {
  enum InterType: String, CaseIterable {
    case variable = "Inter-VariableFont"
  }

  enum Inter {
    static func variable(
      configuration: O2FontStyle.Configuration
    ) -> Font {
      .customFont(name: Font.InterType.variable.rawValue, configuration: configuration)
    }
  }
}
