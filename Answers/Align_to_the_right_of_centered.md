```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI horizontal alignment from center to the right (by andrewz)

A: Here is possible approach based on alignment guides. Tested with Xcode 11.3 / iOS 13.3.

![Bi1ja](https://user-images.githubusercontent.com/62171579/180619057-d5495692-792a-48a6-aad2-85f954980ba7.png)

Define custom alignment

    extension HorizontalAlignment {
       private enum HCenterAlignment: AlignmentID {
          static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
             return dimensions[HorizontalAlignment.center]
          }
       }
       static let hCenterred = HorizontalAlignment(HCenterAlignment.self)
    }

align needed element of internal `HStack` to external `VStack` using custom alignment guide

```
struct TestRightCenterred: View {
    var body: some View {
        VStack(alignment: .hCenterred) {
            HStack(spacing: 4) {
                Text("12").border(Color.red) // << just for test
                    .alignmentGuide(.hCenterred, computeValue: { $0.width / 2.0 })
                Text("+3")
                Text("+10")
                Text("-1")
            }
        }
        .frame(maxWidth: .infinity, alignment: Alignment(horizontal: .hCenterred, vertical: .center))
    }
}
```
