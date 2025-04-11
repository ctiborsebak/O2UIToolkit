import SwiftUI

/// Configuration of trailing button, the button is removed when set to nil. Defaults to nil.
public struct InputViewActionButtonConfiguration {
  let icon: Image
  let onTap: () -> Void

  /// - Parameters:
  ///    - icon: Icon of the trailing button.
  ///    - onTap: Trailing buttons action.
  public init(
    icon: Image,
    onTap: @escaping () -> Void
  ) {
    self.icon = icon
    self.onTap = onTap
  }
}

struct InputViewActionButton: View {
  let configuration: InputViewActionButtonConfiguration
  let isFocused: Bool

  var body: some View {
    Button {
      configuration.onTap()
    } label: {
      let icon = configuration.icon
        .resizable()
        .scaledToFit()
        .padding(.Spacing.XS)

      ZStack {
        icon
          .tint(Color.Surface.xHigh)

        if isFocused {
          icon
            .tint(Color.State.Default.focus)
        }
      }
    }
    .frame(width: 32, height: 32)
  }
}

// MARK: - Previews

#if DEBUG
#Preview("Plain") {
  InputViewActionButton(
    configuration: .init(
      icon: Image(systemName: "heart.fill"),
      onTap: { }
    ),
    isFocused: false
  )
}

#Preview("Focused") {
  InputViewActionButton(
    configuration: .init(
      icon: Image(systemName: "heart.fill"),
      onTap: { }
    ),
    isFocused: true
  )
}
#endif
