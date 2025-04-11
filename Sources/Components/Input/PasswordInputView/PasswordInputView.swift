import SwiftUI

/// A secure entry input view.
public struct PasswordInputView: View {
  private let configuration: PasswordInputViewConfiguration
  private var requirementValidator = PasswordRequirementValidator()

  /// - Parameters:
  ///   - configuration: A configuration of the view which will define its style as well as behavior.
  public init(configuration: PasswordInputViewConfiguration) {
    self.configuration = configuration
  }

  @State var accentColor: Color?
  @State var isSecureTextEntry: Bool = true

  @FocusState var isFocused: Bool

  public var body: some View {
    VStack(alignment: .leading, spacing: .Spacing.S) {
      InputView(
        configuration: .init(
          text: configuration.text,
          title: configuration.title,
          placeholder: configuration.placeholder,
          isOptional: configuration.isOptional,
          trailingActionButtonConfiguration: .init(
            icon: Image(systemName: isSecureTextEntry ? "eye.circle.fill" : "eye.slash.circle.fill"),
            onTap: { isSecureTextEntry.toggle() }
          )
        ),
        isSecureTextEntry: isSecureTextEntry,
        accentColor: accentColor
      )
      .focused($isFocused)

      if isFocused {
        PasswordRequirementsBubble(
          text: configuration.text.wrappedValue,
          requirements: configuration.requirements,
          accentColor: accentColor
        )
      }
    }
    .onChange(of: configuration.text.wrappedValue) { _, newValue in
      let (results, color) = requirementValidator.validateRequirements(
        text: newValue,
        requirements: configuration.requirements
      )
      configuration.requirementResults.wrappedValue = results
      accentColor = color
    }
    .onChange(of: isFocused) { _, newValue in
      if newValue {
        let (results, color) = requirementValidator.validateRequirements(
          text: configuration.text.wrappedValue,
          requirements: configuration.requirements
        )
        configuration.requirementResults.wrappedValue = results
        accentColor = color
      }
    }
  }
}

// MARK: - Previews

#if DEBUG
import Foundation

#Preview("Plain") {
  @Previewable @State var text = ""
  @Previewable @State var results: [Bool] = []

  let requirements: [PasswordRequirement] = .previewRequirements

  PasswordInputView(
    configuration: .init(
      text: $text,
      title: "Password",
      placeholder: "Enter password",
      requirements: requirements,
      requirementResults: $results
    )
  )
  .padding(16)
  .setupO2UIToolkitForPreviews()
}

#Preview("Optional") {
  @Previewable @State var text = ""
  @Previewable @State var results: [Bool] = []

  let requirements: [PasswordRequirement] = .previewRequirements

  PasswordInputView(
    configuration: .init(
      text: $text,
      title: "Password",
      placeholder: "Enter password",
      requirements: requirements,
      requirementResults: $results,
      isOptional: true
    )
  )
  .padding(16)
  .setupO2UIToolkitForPreviews()
}

private extension [PasswordRequirement] {
  @MainActor static let previewRequirements: Self = [
    .init(caption: "At least 8 characters") { $0.hasMinimumLength(8) },
    .init(caption: "Contains an uppercase letter") { $0.containsUppercaseLetter },
    .init(caption: "Contains a number") { $0.containsNumber },
    .init(caption: "Contains onf of ? = # / %") { $0.containsAnySymbol(from: "?=#/%") }
  ]
}

private extension String {
  func hasMinimumLength(_ minimalLenght: Int) -> Bool {
    count >= minimalLenght
  }

  var containsUppercaseLetter: Bool {
    range(of: "[A-Z]", options: .regularExpression) != nil
  }

  var containsNumber: Bool {
    range(of: "[0-9]", options: .regularExpression) != nil
  }

  func containsAnySymbol(from symbols: String) -> Bool {
    let escaped = NSRegularExpression.escapedPattern(for: symbols)
    let pattern = "[\(escaped)]"

    return range(of: pattern, options: .regularExpression) != nil
  }
}
#endif
