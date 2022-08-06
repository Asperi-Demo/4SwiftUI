>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to set a delay for the animated Image in SwiftUI? (by J A S K I E R)

A: Here is SwiftUI only variant. Tested with Xcode 11.4 / iOS 13.4. (Sizes/frames if needed can be configured, for demo it does not matter)

![3yy2D](https://user-images.githubusercontent.com/62171579/183258154-24eed53b-b2ed-4f11-b19c-ecd5d8e7b60c.gif)

```
struct EyesBlinkView: View {

    enum EyesState: String {
        case open = "eyes-open"
        case closed = "eyes-closed"
    }

    @State private var eyesState = EyesState.open
    var body: some View {
        Image(eyesState.rawValue).resizable().scaledToFit()
            .onAppear { self.blink() }
    }

    private func blink() {
        self.eyesState = .closed
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.eyesState = .open

            DispatchQueue.main.asyncAfter(deadline: 
                  DispatchTime.now().advanced(by: .seconds(Int.random(in: 1..<9)))) {
                self.blink()
            }
        }
    }
}
```
