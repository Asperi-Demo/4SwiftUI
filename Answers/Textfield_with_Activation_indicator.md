```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: MacOS swiftUI Textfield field with Activation indicator (by Paul)

A: Find below a simple demo of possible approach - just plain styled `TextField`
with everything else have been set up in background. The activation is tracked
by using `FocusState` and animation of just inserted shape as indicator.

Tested with Xcode 13.3 / macOS 12.2

![textfield_activation](https://user-images.githubusercontent.com/62171579/162579235-4ae9001a-31ab-4020-969c-9769bcfb63cc.gif)

```
struct ContentView: View {
  @State private var text = ""
  @FocusState private var highlight

  var body: some View {
    TextField("Placeholder", text: $text)
    .focused($highlight)
    .textFieldStyle(PlainTextFieldStyle()).padding(8)
    .background(
      RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(0.2))
        .overlay(VStack {
          if highlight {
            Rectangle().fill(.blue)
              .frame(height: 2)
              .transition(.scale)
          }
        }.animation(.default, value: highlight), alignment: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    .frame(width: 200)
  }
}
```

Complete test module is [in repository](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_macOS/PlayOn_macOS/Findings/TestTextFieldActivationEffect.swift)
