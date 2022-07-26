```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to assign value to a variable that's 'Get-Only'? (by A4_TS)

A: `GestureState` is alive while gesture is active and must be used only inside this time-frame, updating correspondingly. After gesture finished the corresponding gesture state is reset to initial value. So to have changes persistent we need to store it separately.

Here is possible approach (tested & works with Xcode 11.2 / iOS 13.2)

    struct ContentView: View {
        @GestureState var magnifyBy = CGFloat(1.0)
        @State var zoomIn = CGFloat(1.0)
        
        var magnification: some Gesture {
            MagnificationGesture()
                .updating($magnifyBy) { value, gestureState, transaction in
                    gestureState = value // gestureState is magnifyBy
            }.onEnded{ value in
                self.zoomIn *= value // < preserve last changes
            }
        }
        
        var body: some View {
            Circle()
                .frame(width: 100 * magnifyBy * zoomIn, //after onEnded magnifyBy=1 again
                       height: 100 * magnifyBy * zoomIn,  
                       alignment: .center)
                .gesture(magnification)
        }
    }

Please see for details on `GestureState` in official Apple article, [Adding Interactivity with Gestures](https://developer.apple.com/documentation/swiftui/gestures/adding_interactivity_with_gestures). That rare case when documentation is full and good.
