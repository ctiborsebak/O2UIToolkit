import SwiftUI

///  A configuration of the view which will define its style as well as behavior.
public struct PasswordInputViewConfiguration {
  var text: Binding<String>
  let title: String
  let placeholder: String
  let requirements: [PasswordRequirement]
  var requirementResults: Binding<[Bool]>
  let isOptional: Bool

  /// - Parameters:
  ///   - text: A binding to a property that determines state of the search field.
  ///   - title: Title dispplayed above the InputView.
  ///   - placeholder: Placeholder text shown in the search field.
  ///   - requirements: Requirements that the password should satisfy. E.g.: "The password should contain a number."
  ///   - isOptional: Displays an optional label.
  public init(
    text: Binding<String>,
    title: String,
    placeholder: String,
    requirements: [PasswordRequirement],
    requirementResults: Binding<[Bool]>,
    isOptional: Bool = false
  ) {
    self.text = text
    self.title = title
    self.placeholder = placeholder
    self.requirements = requirements
    self.requirementResults = requirementResults
    self.isOptional = isOptional
  }
}
