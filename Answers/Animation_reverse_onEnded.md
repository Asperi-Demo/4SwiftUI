```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: how to do a simple scaling animation and why isn't this working - i tried this here which 
simply shrinks and then scales the circle again? (by Chris)

A: Here is possible approach (based on `AnimatableModifier`). Actually it demonstrates 
how current animation end can be detected, and performed something - in this 
case, for your scaling scenario, just initiate reversing.

![Md8dn](https://user-images.githubusercontent.com/62171579/164772728-c0d7188b-e355-418b-84b8-16b4bedc5c43.gif)

Simplified & modified your example

```
struct TestReversingScaleAnimation: View {

    @State var scaleImage : CGFloat = 1

    var body: some View {
        VStack {
            Button("Start animation") {
                self.scaleImage = 0.01       // initiate animation
            }

            Image(systemName: "circle.fill")
                .modifier(ReversingScale(to: scaleImage) {
                    self.scaleImage = 1      // reverse set
                })
                .animation(.default)         // now can be implicit
        }
    }
}
```

Actually, show-maker here... important comments inline.

## Updated for Xcode 13.3 (tested with iOS 15.4) ##

```
struct ReversingScale: AnimatableModifier {
    var value: CGFloat

    private let target: CGFloat
    private let onEnded: () -> ()

    init(to value: CGFloat, onEnded: @escaping () -> () = {}) {
        self.target = value
        self.value = value
        self.onEnded = onEnded // << callback
    }

    var animatableData: CGFloat {
        get { value }
        set { value = newValue
            // newValue here is interpolating by engine, so changing
            // from previous to initially set, so when they got equal
            // animation ended
            let callback = onEnded
            if newValue == target {
				DispatchQueue.main.async(execute: callback)
            }
        }
    }

    func body(content: Content) -> some View {
        content.scaleEffect(value)
    }
}
```

## Original variant (tested with Xcode 11.4 / iOS 13.4) ##

```
struct ReversingScale: AnimatableModifier {
    var value: CGFloat

    private var target: CGFloat
    private var onEnded: () -> ()

    init(to value: CGFloat, onEnded: @escaping () -> () = {}) {
        self.target = value
        self.value = value
        self.onEnded = onEnded // << callback
    }

    var animatableData: CGFloat {
        get { value }
        set { value = newValue
            // newValue here is interpolating by engine, so changing
            // from previous to initially set, so when they got equal
            // animation ended
            if newValue == target {
                onEnded()
            }
        }
    }

    func body(content: Content) -> some View {
        content.scaleEffect(value)
    }
}
```

[Test module in project here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestReversingScaleAnimation.swift)
