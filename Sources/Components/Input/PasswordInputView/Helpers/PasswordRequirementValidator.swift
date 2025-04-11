import SwiftUI

struct PasswordRequirementValidator {
  func validateRequirements(
    text: String,
    requirements: [PasswordRequirement]
  ) -> (
    results: [Bool],
    accentColor: Color?
  ) {
    let results = requirements.map { $0.predicate(text) }
    let areAllMet = results.allSatisfy { $0 }
    let accentColor = areAllMet ? nil : Color.Content.OnNeutral.danger

    return (results, accentColor)
  }
}
