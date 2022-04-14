```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Broken explicit animations in NavigationView? (by )

A: The initial construction flow of `NavigationView` is very complicated and long, actually 
as it is seen from debugging something might be recreated several times, so it is better
to delay any animation (as well as probably anthing required final view hierarchy) until 
next event loop (construction phase is synchronous and completes in one event).

Here is a demo of approach to fix the issue. Tested with Xcode 12 / iOS 14.

![JCkok](https://user-images.githubusercontent.com/62171579/163337120-2212a90c-9977-4af2-afa6-07855c01d689.gif)


```
struct EscapingAnimationTest: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                EscapingAnimationTest_Inner()
                Spacer()
            }
            .backgroundFill(Color.blue)
        }
    }
}

struct EscapingAnimationTest_Inner: View {
    @State var degrees: CGFloat = 0
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: 0.3)
            .stroke(Color.red, lineWidth: 5)
            .rotationEffect(Angle(degrees: Double(degrees)))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: degrees)
            .onAppear() {
                DispatchQueue.main.async {    // << here !!
                    degrees = 360
                }
            }
    }
}
```

the same will be using `withAnimation`

    .onAppear() {
      DispatchQueue.main.async {
        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
              degrees = 360
        }
      }
    }
