```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to clip a view while using a SwiftUI .move transition / animation (by LLooggaann)

A: It is possible to do by clipping exact container of 'drawer'. Here is a demo of possible approach. 

Tested with Xcode 13.2 / iOS 15.2 (Simulator slow animation is ON for better demo)

![EMbUN](https://user-images.githubusercontent.com/62171579/179396164-ca8a6b05-63b7-4dc3-a05a-1704980fbb5d.gif)

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack {
                if showingSecondView {
                    ZStack {
                        Color.green.opacity(0.25)
                        Text("Second View")
                    }
                    .transition(.move(edge: .bottom))
                } else {
                    Color.clear // << replacement for transition visibility
                }
            }
            .frame(width: 300, height: 300)
            .animation(.easeInOut, value: showingSecondView)  // << animate drawer !!
            .clipped()            // << clip drawer area
            
            ZStack {
                Color.black.opacity(0.2)
                Text("First View")
            }
            .frame(width: 300, height: 300)

            Button("Animate In / Out") {
                showingSecondView.toggle()
            }
            .padding()
        }
    }
