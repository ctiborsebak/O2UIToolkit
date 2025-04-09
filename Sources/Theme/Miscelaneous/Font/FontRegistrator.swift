import SwiftUI

struct FontRegistrator {
  static func registerFonts() {
    Font.InterType.allCases.forEach {
      registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "ttf")
    }
  }

  private static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
    guard
      let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
      let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
      let font = CGFont(fontDataProvider)
    else {
      return
    }

    var error: Unmanaged<CFError>?

    CTFontManagerRegisterGraphicsFont(font, &error)
  }
}
