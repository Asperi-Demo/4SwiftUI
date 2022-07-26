```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How do I make a SwiftUI gesture that keeps running code while the view is pressed (by Lou Franco)

A: Use instead the following combination to track continuous pressing down

Tested with Xcode 11.4 / iOS 13.4

```
@GestureState var isLongPress = false // will be true till tap hold

var plusLongPress: some Gesture {
    LongPressGesture(minimumDuration: 1).sequenced(before:   
          DragGesture(minimumDistance: 0, coordinateSpace: 
          .local)).updating($isLongPress) { value, state, transaction in
            switch value {
                case .second(true, nil):
                    state = true
                   // side effect here if needed
                default:
                    break
            }
        }
}
```
