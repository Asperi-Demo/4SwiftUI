>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: animate path stroke drawing in SwiftUI (by DevB2F)

A: 

### Re-tested: Xcode 13.4 / iOS 15.5

![ezgif com-gif-maker-88](https://user-images.githubusercontent.com/62171579/181582923-93863c62-b4cb-49ed-8482-fe5f62acd45d.gif)

It can be used `.trim` with animatable end, like below with your modified code

```swift
struct MyLines: View {
    var height: CGFloat
    var width: CGFloat

    @State private var percentage: CGFloat = .zero
    var body: some View {

        // ZStack {         // as for me, looks better w/o stack which tighten path
            Path { path in
                path.move(to: CGPoint(x: 0, y: height/2))
                path.addLine(to: CGPoint(x: width/2, y: height))
                path.addLine(to: CGPoint(x: width, y: 0))
            }
            .trim(from: 0, to: percentage) // << breaks path by parts, animatable
            .stroke(Color.black, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            .animation(.easeOut(duration: 2.0), value: percentage) // << animate
            .onAppear {
                self.percentage = 1.0 // << activates animation for 0 to the end
            }

        //}
    }
}
```
