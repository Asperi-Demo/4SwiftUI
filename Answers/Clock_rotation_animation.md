```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Problem animating with animatableData in SwiftUI (by Anton)

A: Here is possible approach - just `animatableData` in View does not work - we have to put it 
in `AnimatableModifier`, also animation should be applied to a container instead of child view.

Tested with Xcode 11.4 / iOS 13.4


![ogmuV](https://user-images.githubusercontent.com/62171579/165682449-6d19fdda-1b8c-4902-98e9-6c2773b2fdde.gif)


```
struct CircleMoving: AnimatableModifier {
    var hoursOffset: CGFloat
    var hour: CGFloat
    var size: CGFloat

    public var animatableData: CGFloat {
        get { hoursOffset }
        set { self.hoursOffset = newValue }
    }

    func body(content: Content) -> some View {
        content
            .position(CGPoint.onCircle(hours: hour + hoursOffset, size: size))
    }
}


struct CircleView: View {

    var hoursOffset: CGFloat

    var body: some View {
        GeometryReader() { geo in
            ForEach(0..<12) { hour in
                ZStack {
                    Text("\(hour)")
                        .modifier(CircleMoving(hoursOffset: self.hoursOffset, hour: CGFloat(hour), size: geo.size.width))
                }
            }
        }
        .animation(.easeInOut(duration: 3.0), value: hoursOffset) // << here !!
    }
}
```

**Optional:** also I would recommend you round point values for better integrity, however it is not much important.

```
extension CGPoint {
    static func onCircle(hours: CGFloat, size: CGFloat) -> CGPoint {
        let radians = (3 - hours) * CGFloat.pi / CGFloat (6)
        let hypotenuse = size / 2
        return CGPoint(x: (size / 2 + 0.8 * hypotenuse * cos(radians)).rounded(.up),
                       y: (size / 2 - 0.8 * hypotenuse * sin(radians)).rounded(.up))
    }
}
```

[Test module in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestCycleClockAnimation.swift)
