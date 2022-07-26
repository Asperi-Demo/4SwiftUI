```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Long press animation with Swift UI (by vasily)

A: The `.accentColor` is not animatable modifier, however you can achieve the same effect (as soon as I understood) with the following approach.

![NH30a](https://user-images.githubusercontent.com/62171579/174657634-fd514a42-a430-434c-8a0c-ad386e8e66a0.gif)

```
struct TestLongPressGesture: View {
    @GestureState var highlight = false
    var body: some View {
        var longPress: some Gesture {
            LongPressGesture(minimumDuration: 3)
                .updating($highlight) { currentstate, gestureState, transaction in
                    transaction.animation = Animation.easeInOut(duration: 2.0)
                    gestureState = currentstate
                }
        }
        return VStack {
            Text("highlight!")
                .gesture(longPress)
            Divider()
            Button("Button") { }
                .font(Font.largeTitle.bold())
                .foregroundColor(.white)
                .colorMultiply(self.highlight ? .green : .blue)     // << here !!
                .animation(.easeInOut, value: highlight)
        }
    }
}
```
