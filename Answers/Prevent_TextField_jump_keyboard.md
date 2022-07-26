```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI | Stop TextField from moving up with keyboard automatically (by Mofawaw)

A: Here is possible solution for your scenario. Tested with Xcode 12 / iOS 14

![bWQ86](https://user-images.githubusercontent.com/62171579/169648652-324c162d-94c0-42a3-8bdc-713438b11621.gif)

```
  var body: some View {
    VStack {
      Spacer()
      TextField("Test", text: $textInput)
      Spacer()
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
  }
```
