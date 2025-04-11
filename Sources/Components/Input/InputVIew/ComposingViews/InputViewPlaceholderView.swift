import SwiftUI

struct InputViewPlaceholderView: View {
  let placeholder: String

  var body: some View {
    Text(placeholder)
      .foregroundColor(.Content.OnNeutral.low)
  }
}

// MARK: - Previews

#if DEBUG
#Preview {
  InputViewPlaceholderView(placeholder: "Placeholder")
}
#endif
