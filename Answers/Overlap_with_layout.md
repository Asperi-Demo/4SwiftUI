```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How can I manage this view when constraints aren't available to me in swiftui? (by swiftandRoll)

A: If you already have such `popUpView` and `myButton` components prepared in SwiftUI, the alignment like on screen can be done actually in two lines

![l2nAE](https://user-images.githubusercontent.com/62171579/177030979-500d4014-1fbd-4102-ba50-fd4224ac5274.png)

```
struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {    // << here !!
            PopUpView()
            MyButton()
                .alignmentGuide(.bottom) { $0.height / 2 } // << here !!
        }
    }
}
```
