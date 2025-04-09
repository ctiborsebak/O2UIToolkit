import SwiftUI

public enum O2UIToolkitAppearance {
  public static func setup() {
    FontRegistrator.registerFonts()
  }
}

#if DEBUG
public extension View {
  func setupO2UIToolkitForPreviews() -> some View {
    O2UIToolkitAppearance.setup()
    return self
  }
}
#endif
