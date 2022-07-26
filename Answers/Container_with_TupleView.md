```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI Pass two child views to View (by Scaraux)

A: Here is possible variant. Tested with Xcode 11.4 / iOS 13.4

```swift
struct FlippableView<V1: View, V2: View>: View {
    @State private var flipped = false
    @State private var degrees = 0.0

    var frontCard: V1
    var backCard: V2

    @inlinable public init(@ViewBuilder content: () -> TupleView<(V1, V2)>) {
        let t = content()
        self.frontCard = t.value.0
        self.backCard = t.value.1
    }

    var body: some View {
        return Group() {
            if self.degrees < 90 {
                self.frontCard
            } else {
                self.backCard
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))

            }
        }
    }
}
```
