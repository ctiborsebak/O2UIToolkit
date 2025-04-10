import SwiftUI

/// Configuration of trailing button, the button is removed when set to nil. Defaults to nil.
public struct InputViewActionButtonConfiguration {
  let icon: Image
  let onTap: () -> Void

  /// Configuration of trailing button, the button is removed when set to nil. Defaults to nil.
  ///
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

  var body: some View {
    Button {
      configuration.onTap()
    } label: {
      configuration.icon
        .resizable()
        .scaledToFit()
        .frame(width: 32, height: 32)
    }
  }
}

#if DEBUG
#Preview {
  InputViewActionButton(
    configuration: .init(
      icon: Image(systemName: "heart.fill"),
      onTap: { }
    )
  )
}
#endif
