```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: When pressed for 2 seconds, the Symbol changes, and after those 2 seconds, when released, the Symbol go back to the initial state. (by Rodolfo Diniz Biazi)

A: Here is a solution. Tested with Xcode 11.5b.

![qUWKq](https://user-images.githubusercontent.com/62171579/176169398-e9ecfda6-3991-4b90-8ec3-b7809ab0f3bf.gif)

```
struct heartButton: View {

    @GestureState private var isDetectingPress = false

    var body: some View {
        VStack {
            Image(systemName: isDetectingPress ? "heart.fill" : "heart").font(.system(size: 16, weight: .regular))
            Text("Press")
            .gesture(LongPressGesture(minimumDuration: 2).sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local)).updating($isDetectingPress) { value, state, _ in
                    switch value {
                        case .second(true, nil):
                            state = true
                            // additional side effect here ...
                        default:
                            break
                    }
            })
        }
        .onChange(of: isDetectingPress) { flag in
           // ... and/or here !!
           print(">> get \(flag)")
        }
    }
}
```
