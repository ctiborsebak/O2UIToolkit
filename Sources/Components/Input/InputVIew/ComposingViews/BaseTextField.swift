import SwiftUI

// NOTE: SwiftUI's native TextField has a default padding around its text which is non-configurable, so we can use UIKit since `setContentHuggingPriority` can be used as a workaround.
struct BaseTextField: UIViewRepresentable {
  @Binding var text: String
  var isSecureTextEntry: Bool = false

  func makeUIView(context: Context) -> UITextField {
    let textField = UITextField()
    textField.borderStyle = .none
    textField.text = text
    textField.delegate = context.coordinator
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .clear
    textField.adjustsFontSizeToFitWidth = false
    textField.setContentHuggingPriority(.required, for: .vertical)
    textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    textField.textAlignment = .left
    textField.autocapitalizationType = .none
    textField.isSecureTextEntry = isSecureTextEntry
    textField.textColor = UIColor(Color.Content.OnNeutral.xxHigh)
    textField.tintColor = UIColor(Color.Content.OnNeutral.medium)
    textField.font = UIFont.fromInterVariable(configuration: O2FontStyle.body(.M).configuration)

    return textField
  }

  func updateUIView(_ uiView: UITextField, context: Context) {
    uiView.text = text
    uiView.isSecureTextEntry = isSecureTextEntry
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(text: $text)
  }

  class Coordinator: NSObject, UITextFieldDelegate {
    @Binding var text: String

    init(text: Binding<String>) {
      _text = text
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
      text = textField.text ?? ""
    }
  }
}

// MARK: - Previews

#if DEBUG
#Preview("Plain") {
  @Previewable @State var text: String = ""

  BaseTextField(text: $text)
    .background(Color.mint)
    .setupO2UIToolkitForPreviews()
}

#Preview("Secure text entry") {
  @Previewable @State var text: String = ""

  BaseTextField(
    text: $text,
    isSecureTextEntry: true
  )
  .background(Color.mint)
  .setupO2UIToolkitForPreviews()
}
#endif
