import SwiftUI

///  A configuration of the view which will define its style as well as behavior.
public struct InputViewConfiguration {
  var text: Binding<String>
  let title: String
  let placeholder: String
  let isOptional: Bool
  let trailingActionButtonConfiguration: InputViewActionButtonConfiguration?
  
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
