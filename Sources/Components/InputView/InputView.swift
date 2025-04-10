import SwiftUI

/// An input view for a text entry.
public struct InputViewConfiguration {
  var text: Binding<String>
  let title: String
  let placeholder: String
  let isOptional: Bool
  let trailingActionButtonConfiguration: InputViewActionButtonConfiguration?

  /// An input view for a text entry.
  ///
  /// - Parameters:
  ///   - text: A binding to a property that determines state of the search field.
  ///   - title: Title dispplayed above the InputView.
  ///   - placeholder: Placeholder text shown in the search field.
  ///   - isOptional: Displays an optional label. Defaults to false.
  ///   - trailingActionButtonConfiguration: Configuration of trailing button, the button is removed when set to nil. Defaults to nil.
  public init(
    text: Binding<String>,
    title: String,
    placeholder: String,
    isOptional: Bool = false,
    trailingActionButtonConfiguration: InputViewActionButtonConfiguration? = nil
  ) {
    self.text = text
    self.title = title
    self.placeholder = placeholder
    self.isOptional = isOptional
    self.trailingActionButtonConfiguration = trailingActionButtonConfiguration
  }
}

public struct InputView: View {
  let configuration: InputViewConfiguration

  public init(configuration: InputViewConfiguration) {
    self.configuration = configuration
  }

  @FocusState var isFocused: Bool

  public var body: some View {
    VStack(alignment: .leading, spacing: .Spacing.XS) {
      InputViewHeaderView(
        title: configuration.title,
        isOptional: configuration.isOptional
      )

      HStack(alignment: .center, spacing: .Spacing.XS) {
        ZStack(alignment: .leading) {
          if configuration.text.wrappedValue.isEmpty && !isFocused {
            InputViewPlaceholderView(placeholder: configuration.placeholder)
          }

          BaseTextField(
            text: configuration.text
          )
          .focused($isFocused)
        }
        .o2FontStyle(.body(.M))
        .padding([.leading, .vertical], .Spacing.S)

        if let trailingActionButtonConfiguration = configuration.trailingActionButtonConfiguration {
          InputViewActionButton(configuration: trailingActionButtonConfiguration)
            .padding([.vertical, .trailing], .Spacing.XS)
        }
      }
      .background(
        ZStack {
          RoundedRectangle(cornerRadius: .CornerRadius.input)
            .stroke(
              isFocused ? Color.State.Default.focus : Color.Surface.xHigh,
              lineWidth: 1
            )
            .blendMode(.plusDarker)
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
