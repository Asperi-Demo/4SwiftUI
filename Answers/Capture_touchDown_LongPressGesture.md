```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Capture touchDown location of onLongPressGesture in swiftUI? (by Adam VZ)

A: Here is a demo of possible approach. It needs a combination of two gestures: LongPress to detect long press and Drag to detect location.

Tested with Xcode 12 / iOS 14. (on below systems it might be needed to add `self.` to some properties usage)

![IcqsO](https://user-images.githubusercontent.com/62171579/171122413-b3ac0434-0118-4264-a7db-2b11552fa2fc.gif)

```
struct ExampleView: View {
    @State var showCustomContextMenu = false
    @State var longPressLocation = CGPoint.zero

    var body: some View {
        Rectangle()
            .foregroundColor(Color.green)
            .frame(width: 100.0, height: 100.0)
            .onTapGesture { showCustomContextMenu = false } // just for demo
            .gesture(LongPressGesture(minimumDuration: 1).sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local))
                .onEnded { value in
                    switch value {
                        case .second(true, let drag):
                            longPressLocation = drag?.location ?? .zero   // capture location !!
                            showCustomContextMenu = true
                        default:
                            break
                    }
            })
            .overlay(
                Rectangle()
                    .foregroundColor(Color.red)
                    .frame(width: 50.0, height: 50.0)
                    .position(longPressLocation)
                    .opacity( (showCustomContextMenu) ? 1 : 0 )
                    .allowsHitTesting(false)
        )
    }
}
```
