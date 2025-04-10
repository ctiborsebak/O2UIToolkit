import SwiftUI

extension InputView {
  /// - Parameters:
  ///   - configuration: A configuration of the view which will define its style as well as behavior.
  public init(
    configuration: InputViewConfiguration
  ) {
    self.configuration = configuration
  }

  init(
    configuration: InputViewConfiguration,
    isSecureTextEntry: Bool = false,
    accentColor: Color? = nil
  ) {
    self.configuration = configuration
    self.isSecureTextEntry = isSecureTextEntry
    self.accentColor = accentColor
  }
}

/// An input view for a text entry.
public struct InputView: View {
  private let configuration: InputViewConfiguration
  private var isSecureTextEntry: Bool = false
  private var accentColor: Color? = nil

  @FocusState var isFocused: Bool

  public var body: some View {
    VStack(alignment: .leading, spacing: .Spacing.XS) {
      InputViewHeaderView(
        title: configuration.title,
        isOptional: configuration.isOptional,
        accentColor: accentColor
      )

      HStack(alignment: .center, spacing: .Spacing.XS) {
        ZStack(alignment: .leading) {
          if configuration.text.wrappedValue.isEmpty && !isFocused {
            InputViewPlaceholderView(placeholder: configuration.placeholder)
          }

          BaseTextField(
            text: configuration.text,
            isSecureTextEntry: isSecureTextEntry
          )
          .focused($isFocused)
        }
        .o2FontStyle(.body(.M))
        .padding([.leading, .vertical], .Spacing.S)

        if let trailingActionButtonConfiguration = configuration.trailingActionButtonConfiguration {
          InputViewActionButton(
            configuration: trailingActionButtonConfiguration,
            isFocused: isFocused
          )
          .padding([.vertical, .trailing], .Spacing.XS)
        }
      }
      .background(
        ZStack {
          RoundedRectangle(cornerRadius: .CornerRadius.input)
            .stroke(Color.Surface.xHigh, lineWidth: 1)

          if isFocused {
            RoundedRectangle(cornerRadius: .CornerRadius.input)
              .stroke(accentColor ?? Color.State.Default.focus, lineWidth: 1)
          }
        }
      )
    }
  }
}

#if DEBUG
#Preview("Plain") {
  @Previewable @State var text: String = ""

  InputView(
    configuration: .init(
      text: $text,
      title: "Input",
      placeholder: "Placeholder",
    )
  )
  .padding(16)
  .setupO2UIToolkitForPreviews()
}

#Preview("Optional with button") {
  @Previewable @State var text: String = ""

  InputView(
    configuration: .init(
      text: $text,
      title: "Input",
      placeholder: "Placeholder",
      isOptional: true,
      trailingActionButtonConfiguration: .init(
        icon: Image(systemName: "clear"),
        onTap: { text = "" }
      )
    )
  )
  .padding(16)
  .setupO2UIToolkitForPreviews()
}
#endif
