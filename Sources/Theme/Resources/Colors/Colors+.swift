import SwiftUI

public extension Color {
  struct Surface {
    public static let xHigh = Color(.coreGray500)
    public static let xLow = Color(.coreGray00)
    public static let brand = Color(.o2Blue500)
    public static let danger = Color(.coreRed600)
    public static let dangerVariant = Color(.coreRed100)
    public static let warning = Color(.coreYellow700)
    public static let warningVariant = Color(.coreYellow100)
  }

  struct Content {
    struct OnNeutral {
      public static let xxHigh = Color(.coreGray950)
      public static let medium = Color(.coreGray500)
      public static let low = Color(.coreGray300)
      public static let danger = Color(.coreRed600)
      // NOTE: This color is inconsistent in the assignment — the Figma color does not match the proposed color hash. In a real-world scenario, this would need to be further discussed with the design team or another accountable person. I am adding this color solely to illustrate the issue, along with this attached note.
      public static let dangerVariant = Color(.coreRed600)
    }
  }

  struct State {
    struct Default {
      public static let hover = Color(.alphaDim).opacity(0.06)
      public static let focus = Color(.alphaDim).opacity(0.8)
    }
  }
}
