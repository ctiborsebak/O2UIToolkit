import SwiftUI

struct InputViewHeaderView: View {
  let title: String
  let isOptional: Bool

  var body: some View {
    HStack(alignment: .center, spacing: .Spacing.XS) {
      Text(title)
        .foregroundStyle(Color.Content.OnNeutral.xxHigh)
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
