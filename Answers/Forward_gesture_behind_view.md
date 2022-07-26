```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: In SwiftUI, how can I perform a gesture but forward gestures to the view behind it? (by Wil Gieseler)

A: Here is a demo of possible approach. Tested with Xcode 11.4 / iOS 13.4

```
struct ContentView: View {
    var body: some View {
        VStack {
            Button("Button") { print("> button tapped")}
        }
        .frame(width: 200, height: 200)
        .contentShape(Rectangle())       // makes all area tappable
        .simultaneousGesture(TapGesture().onEnded({
             print(">>> tooltip area here")
        }))
        .border(Color.red)   // just for demo show area
    }
}
```
