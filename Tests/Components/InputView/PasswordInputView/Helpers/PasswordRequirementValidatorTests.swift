import Testing

@testable import O2UIToolkit

@Suite
struct PasswordRequirementValidatorTests {
@Test
  func sut_should_update_requirements_not_satisfied() {
    let requirements = [
      PasswordRequirement(caption: "Contains 4 characters.") { $0.count >= 4 },
      PasswordRequirement(caption: "Contains a \"%") { $0.contains("%") },
      PasswordRequirement(caption: "Contains a \"$") { $0.contains("$") }
    ]

    let sut = PasswordRequirementValidator()

    let (results, color) = sut.validateRequirements(
      text: "Password%",
      requirements: requirements
    )

    #expect(results == [true, true, false])
    #expect(color == .Content.OnNeutral.danger)
  }
}
