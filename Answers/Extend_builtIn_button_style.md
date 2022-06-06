```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I extend system default ButtonStyle class (by Nic Wanavit)

A: Inheritance is possible only for classes, but majority of SwiftUI types are structs (ie. values), so we need to use composition instead, combining needed features with sequence of modifiers, like

### Updated: Xcode 13.4 / iOS 15.5

![NCH8G](https://user-images.githubusercontent.com/62171579/172173052-bfd1027e-db7b-4be3-8d60-94178a87317c.png)

```
struct ContentView: View {
  var body: some View {
    Button("Demo") { }
      .buttonStyle(.crazy)

  }
}

struct CrazyButtonStyle: PrimitiveButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Button(configuration)
          .buttonStyle(.bordered)
            .foregroundColor(.red)
    }
}

extension PrimitiveButtonStyle where Self == CrazyButtonStyle {
  static var crazy: CrazyButtonStyle { CrazyButtonStyle() }
}
```

### Original variant:

```
@available(iOS 15.0, *)
extension Button {
  func crazyButton() -> some View {
    self.buttonStyle(.bordered)
      .foregroundColor(.red)
  }
}
```

and usage:

  var body: some View {
    Button("Crazy") {
      // ... action here
    }
    .crazyButton()
  }

