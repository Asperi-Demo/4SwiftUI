```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI HStack with equal Height (by mica)

A: Here is possible approach using `.alignmentGuide`

![tDxuA](https://user-images.githubusercontent.com/62171579/166226221-2c7c585a-186c-4086-9ee8-ba67970e97e3.png)

```swift
struct Test7: View {
    @State
    private var height: CGFloat = .zero // < calculable height

    var body: some View {
        HStack (alignment: .top) {
            Text( "111")                     
                .frame(minHeight: height)    // in Preview default is visible
                .background(Color.red)

            VStack(alignment: .leading) {    
                Text("2222222")
                    .background(Color.gray)
                Text("333333333")
                    .background(Color.blue)
            }
            .alignmentGuide(.top, computeValue: { d in
                DispatchQueue.main.async { // << dynamically detected - needs to be async !!
                    self.height = max(d.height, self.height)
                }
                return d[.top]
            })
        }
        .background(Color.yellow)
    }
}
```

Note: real result is visible only in LivePreview, because height is calculated dynamically and assign in next rendering cycle to avoid conflicts on @State.

