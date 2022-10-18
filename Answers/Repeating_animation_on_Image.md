```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Repeating animation on SwiftUI Image (by fulvio)

A: Here is possible solution for continuous progressing on appear & start/stop 
based on combination for conditional image and appear/disappear modifiers. 

Tested with Xcode 11.4 / iOS 13.4.

![mhSjE](https://user-images.githubusercontent.com/62171579/163709380-78f828d5-20d6-4d45-a4c1-ab3a5906e986.gif)


```
struct PeopleList : View {
    @State private var isAnimating = false
    @State private var showProgress = false
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }

    var body: some View {
        Button(action: { self.showProgress.toggle() }, label: {
            if showProgress {
                Image(systemName: "arrow.2.circlepath")
                    .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                    .animation(self.isAnimating ? foreverAnimation : .default, value: self.isAnimating) // << update !!
                    .onAppear { self.isAnimating = true }
                    .onDisappear { self.isAnimating = false }
            } else {
                Image(systemName: "arrow.2.circlepath")
            }
        })
        .onAppear { self.showProgress = true }
    }
}
```
