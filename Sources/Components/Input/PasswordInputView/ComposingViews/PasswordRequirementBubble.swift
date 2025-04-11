import SwiftUI

struct PasswordRequirementsBubble: View {
  let text: String
  let requirements: [PasswordRequirement]
  let accentColor: Color?

  var body: some View {
    VStack(alignment: .leading, spacing: .Spacing.XS) {
      Text("Password Requirements")
        .font(.caption)
        .foregroundColor(Color.Content.OnNeutral.medium)
        .padding(.Spacing.XS)
        .background(Color.State.Default.hover)
        .cornerRadius(.CornerRadius.input)

      ForEach(requirements) { requirement in
        let isFullfilled = requirement.predicate(text)

        PasswordRequirementBubble(
          requirement: requirement,
          isFullfilled: isFullfilled,
          accentColor: accentColor
        )
      }
    }
    .padding([.top, .bottom], .Spacing.XS)
    .padding([.leading, .trailing], .Spacing.S)
    .background(
      RoundedRectangle(cornerRadius: .CornerRadius.input)
        .fill(Color.Surface.xLow)
        .shadow(radius: .Shadow.radius)
    )
  }
}

struct PasswordRequirementBubble: View {
  let requirement: PasswordRequirement
  let isFullfilled: Bool
  let accentColor: Color?

  var body: some View {
    HStack {
      Image(systemName: isFullfilled ? "checkmark.circle.fill" : "circle")
        .foregroundColor(isFullfilled ? Color.Content.OnNeutral.medium : accentColor ?? Color.Content.OnNeutral.medium)
        .frame(width: 16, height: 16)

      Text(requirement.caption)
        .font(.caption)
        .foregroundColor(isFullfilled ? Color.Content.OnNeutral.medium : accentColor ?? Color.Content.OnNeutral.medium)
    }
    .padding(.Spacing.XS)
    .background(isFullfilled ? Color.State.Default.hover : accentColor?.opacity(0.2) ?? Color.Content.OnNeutral.medium.opacity(0.2))
    .cornerRadius(.CornerRadius.input)
  }
}

// MARK: - Previews

#if DEBUG
#Preview {
  let requirements: [PasswordRequirement] = [
    .init(caption: "At least 8 characters") { $0.count >= 8 },
    .init(caption: "Contains a number") { $0.rangeOfCharacter(from: .decimalDigits) != nil },
    .init(caption: "Contains an uppercase letter") { $0.rangeOfCharacter(from: .uppercaseLetters) != nil }
  ]

  PasswordRequirementsBubble(
    text: "Password",
    requirements: requirements,
    accentColor: Color.red
  )
}
#endif
