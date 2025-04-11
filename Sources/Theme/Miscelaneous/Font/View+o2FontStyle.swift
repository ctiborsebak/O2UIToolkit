import SwiftUI

extension O2FontStyle {
  var configuration: Configuration {
    switch self {
    case .label(.M):
        .init(
          size: 16,
          weight: 500,
          lineHeight: 22,
          letterSpacing: 0.16
        )

    case .label(.S):
        .init(
          size: 14,
          weight: 550,
          lineHeight: 17,
          letterSpacing: 0.16
        )

      // NOTE: I understand that the assignment also includes requirements for paragraph and list spacing. In my opinion, these are best managed through the layout of the view, as it provides more flexibility compared to modifying the String itself and forcing its behavior wherever it's used. However, if necessary, this can be achieved using AttributedString instead of a ViewModifier.
    case .body(.M):
        .init(
          size: 16,
          weight: 400,
          lineHeight: 22,
          letterSpacing: 0.01
        )
    }
  }

  struct Configuration {
    var size: CGFloat
    var weight: CGFloat
    var lineHeight: CGFloat
    var letterSpacing: CGFloat
  }
}

public extension View {
  func o2FontStyle(_ style: O2FontStyle) -> some View {
    modifier(O2FontViewModifier(configuration: style.configuration))
  }
}

public struct O2FontViewModifier: ViewModifier {
  let configuration: O2FontStyle.Configuration

  init (configuration: O2FontStyle.Configuration) {
    self.configuration = configuration
  }

  public func body(
    content: Content
  ) -> some View {
    content
      .font(
        .Inter.variable(configuration: configuration)
      )
      .lineSpacing(
        configuration.lineHeight - configuration.size
      )
      .kerning(configuration.letterSpacing)
  }
}

#if DEBUG
#Preview("Label.M") {
  FontPreviewView(
    texts: [
      "Hello, world, Label.S",
      "Hello, world, Label.M Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline"
    ],
    style: .label(.M)
  )
}

#Preview("Label.S") {
  FontPreviewView(
    texts: [
      "Hello, world, Label.S",
      "Hello, world, Label.M Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline"
    ],
    style: .label(.S)
  )
}

#Preview("Body.M") {
  FontPreviewView(
    texts: [
      "Hello, world, Label.S",
      "Hello, world, Label.M Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline Multiline"
    ],
    style: .body(.M)
  )
}

private struct FontPreviewView: View {
  let texts: [String]
  let style: O2FontStyle

  var body: some View {
    VStack(spacing: 40) {
      ForEach(texts, id: \.self) { text in
        Text(text)

        Divider()
      }
    }
    .o2FontStyle(style)
    .setupO2UIToolkitForPreviews()
  }
}
#endif
