import SwiftUI

public enum O2FontStyle {
  case label(Label)
  case body(Body)

  public enum Label {
    /// Semi-bold size 16
    case M
    /// Semi-bold size 14
    case S
  }

  public enum Body {
    /// Regular size 16
    case M
  }
}
