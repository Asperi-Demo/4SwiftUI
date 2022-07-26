```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Button Stroke Set Gap In specific position Swiftui

A: The possible approach is to prepare needed shape using `Arc` and then rotate it to what ever position needed.

Demo prepared with Xcode 13.2 / iOS 15.2

![hVvUF](https://user-images.githubusercontent.com/62171579/181005515-6b993809-0bf8-4a1e-8adf-54a3acec4b1e.png)

```
struct DemoView: View {

    var body: some View {
        VStack{
            Button(action: {
                print("Round Action")
            }) {
                Text("Press")
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.black)
                    .background(Color.red)
                    .clipShape(Circle()).padding(5)
                    .overlay(
                        RotatedShape(shape: CutShape(), angle: .degrees(-120))
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
        }
    }
}

private struct CutShape: Shape {
  func path(in rect: CGRect) -> Path {
    Path {
      $0.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.midY, startAngle: Angle(degrees: -5), endAngle: Angle(degrees: 5), clockwise: true)
    }
  }
}
```
