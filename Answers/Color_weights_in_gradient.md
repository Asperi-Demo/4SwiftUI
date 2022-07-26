```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Is it possible to add "Weights" to the colors in a SwiftUI Gradient? (by Liam Keeley)

A: Here is possible solution. Tested with Xcode 11.4 / iOS 13.4

*Note: of course parameters can be modified for your needs*

![Z3e3I](https://user-images.githubusercontent.com/62171579/177608090-56e5278e-3cac-4f3f-82b5-eb3a79101333.gif)

```
struct DemoGradientShift: View {
    private var grade = Gradient(colors: [.red, .blue])
    @State private var value: CGFloat = 50
    var body: some View {
        ZStack {
            VStack {
                Rectangle().fill(Color.red)
                Rectangle().fill(Color.blue)
            }
            Rectangle().fill(LinearGradient(gradient: grade, startPoint: .top, endPoint: .bottom))
                .offset(x: 0, y: 5 * (50 - value))
            Slider(value: $value, in: 1...100)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
```
