import SwiftUI

// NOTE: SwiftUI's native TextField has a default padding around its text which is non-configurable, so we can use UIKit as a workaround since we can use `setContentHuggingPriority` as a workaround.
struct BaseTextField: UIViewRepresentable {
  @Binding var text: String

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

    return textField
  }

  func updateUIView(_ uiView: UITextField, context: Context) {
    uiView.text = text
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

#if DEBUG
#Preview {
  @Previewable @State var text: String = ""

  BaseTextField(text: $text)
    .background(Color.mint)
    .setupO2UIToolkitForPreviews()
}
#endif
