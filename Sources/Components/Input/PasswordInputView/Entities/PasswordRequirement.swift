import Foundation

/// Requirements of a password
///
/// Requirements that should be satisfied by the passowrd. E.g.: The minimal lenght of a password is 8 characters, uses uppercased letters and atleast one number.
public struct PasswordRequirement: Identifiable {
  public let id = UUID()
  let caption: String
  let predicate: (String) -> Bool

  /// - Parameters:
  ///   - caption: Caption that is tied to the requirement and that will be displayed to the user. E.g.: "The password must contain atleast 1 number."
  ///   - predicate: Predicate that the requirement must fullfill.
  public init(
    caption: String,
    predicate: @escaping (String) -> Bool
  ) {
    self.caption = caption
    self.predicate = predicate
  }
}
