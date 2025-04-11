import SwiftUI

struct InputViewHeaderView: View {
  private let title: String
  private let isOptional: Bool
  private let accentColor: Color?

  init(
    title: String,
    isOptional: Bool,
    accentColor: Color? = nil
  ) {
    self.title = title
    self.isOptional = isOptional
    self.accentColor = accentColor
  }

  var body: some View {
    HStack(alignment: .center, spacing: .Spacing.XS) {
      Text(title)
        .foregroundStyle(accentColor ?? Color.Content.OnNeutral.xxHigh)
        .o2FontStyle(.label(.M))

      if isOptional {
        Text("Optional")
          .foregroundStyle(Color.Content.OnNeutral.low)
          .o2FontStyle(.label(.S))
      }

      Spacer()
    }
  }
}

// MARK: - Previews

#if DEBUG
#Preview("Plain") {
  InputViewHeaderView(
    title: "Input",
    isOptional: false
  )
}

#Preview("Accented") {
  InputViewHeaderView(
    title: "Input",
    isOptional: false,
    accentColor: .green
  )
}
#endif
