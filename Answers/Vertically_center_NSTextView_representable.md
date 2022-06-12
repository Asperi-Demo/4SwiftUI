```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How do I vertically center an NSTextView in a SwiftUI view with NSViewRepresentable? (by David Moles)

A: If you just need to show `NSAttributedString`, as I understood, then approach based on `NSTextField`, as shown below, is more appropriate, because `NSTextView` does not have default internal layout and requires explicit external frame.

![Xd0Uz](https://user-images.githubusercontent.com/62171579/173223760-c16cbe68-8121-49a8-8d91-dd37b2830863.gif)

Here is modified representable, `ContentView` does not require changes.

```
struct TextView: NSViewRepresentable {
  typealias NSViewType = NSTextField

  var text: NSAttributedString

  func makeNSView(context: Context) -> NSTextField {
    let view = NSTextField()
    // set background color to show view bounds
    view.backgroundColor = NSColor.systemBlue
    view.drawsBackground = true
    view.isEditable = false
    view.isSelectable = false
    view.lineBreakMode = .byWordWrapping
    view.maximumNumberOfLines = 0
    view.translatesAutoresizingMaskIntoConstraints = false
    view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    view.setContentCompressionResistancePriority(.required, for: .vertical)
    return view
  }

  func updateNSView(_ nsView: NSTextField, context: Context) {
    nsView.attributedStringValue = text
  }
}
```
