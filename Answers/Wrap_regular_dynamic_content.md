```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to stop swiftui from moving content off screen in HStack? (by NotAPhoenix)

A: **SwiftUI 2.0**

Use LazyVGrid as in demo below

![xK5Xx](https://user-images.githubusercontent.com/62171579/178429634-5da295c2-2d65-4cfe-b3fa-ec95b3499071.png)


```
struct SplitTextView: View {
    static let input = "B, LB, Y, RT, A, X, B, Right, X, LB, LB, LB"
    let letters = input.components(separatedBy: ", ")

    let layout = [
        GridItem(.adaptive(minimum:32), spacing: 10)
    ]

    var body: some View {
        LazyVGrid(columns: layout, spacing: 10){
            ForEach(0..<self.letters.count) { index in
                ButtonGeneratorView(buttonKey: self.letters[index])
            }
        }
    }
}
```

**SwiftUI 1.0**

There is no native built-in feature for this. The solution for similar problem I provided in [SwiftUI HStack with wrap and dynamic height](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/HStack_with_wrap_dynamic_height.md), and it can be adapted for this task as well.
