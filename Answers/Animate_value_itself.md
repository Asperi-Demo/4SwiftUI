>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI: Can you animate a change in data itself, not just a view's response to the change? (by Jamie Quade)

A: Here is a demo of possible approach. Tested with Xcode 12 / iOS 14

![kIKRC](https://user-images.githubusercontent.com/62171579/181594130-2f68b6d0-735f-46fd-99ca-075d95a62dc1.gif)

```
struct DemoAnimatingNumber: View {
    @State private var number = Double.zero

    var body: some View {
        Rectangle().fill(Color.yellow)
            .frame(maxWidth: .infinity, maxHeight: 60)
            .modifier(AnimatingNumber(number: number))
            .animation(Animation.easeInOut(duration: 2), value: number)
            .onTapGesture {
                number = number == Double.zero ? 10 : Double.zero
            }
    }
}

struct AnimatingNumber: AnimatableModifier {
    var number: Double

    var animatableData: Double {
        get { number }
        set { number = newValue }
    }

    func body(content: Content) -> some View {
        content.overlay(
            Text("Number: \(number, specifier: "%.1f")")
                .foregroundColor(.blue)
        )
    }
}
```
