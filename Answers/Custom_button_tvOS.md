```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: onFocusChange not triggered in SwiftUI tvOS (by Waheed Abbas)

A: The goal the question is unclear, but here is a simple demo of alternate approach to have managed focused & button click using custom button style. Maybe this will be helpful.

Tested with Xcode 12 / tvOS 14 (Simulator) - compare regular button vs custom button

![1z6jC](https://user-images.githubusercontent.com/62171579/174466038-561f85bd-2c74-4653-988a-21cf4fbe8ec7.gif)

```
struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
    }
}

struct ContentView: View {
    @State private var focused = false
    var body: some View {
        VStack {
            Button(action: {
                print(">>>> custom button")
            }) { LabelView() }.buttonStyle(MyButtonStyle())

            Button("Regular Button") {
                print(">> regular button")
            }
        }
    }
}

struct LabelView: View {
    @Environment(\.isFocused) var focused: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: 200, height: 100)
            .foregroundColor(focused ? .blue : .gray)
            .overlay(Text("Title").foregroundColor(.white))
    }
}
```
