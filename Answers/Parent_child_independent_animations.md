```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: swiftui, animation applied to parent effect child animation (by foolbear)

A: If there are several simultaneous animations the generic solution (in majority of cases) is to use explicit state value for each.

So here is a corrected code (tested with Xcode 12.1 / iOS 14.1, use Simulator or Device, Preview renders some transitions incorrectly)

![qhhbU-2](https://user-images.githubusercontent.com/62171579/169638636-7c68f204-8a44-4ee9-ac2d-b26c1ec50894.gif)

```
struct AnimationTestView: View {
    @State private var go = false
    var body: some View {
        VStack {
            Button("Go!") {
                go.toggle()
            }
        VStack {      // container needed for correct transition !!
          if go {
             RectangleView()
                .transition(.slide)
          }
        }.animation(.easeInOut, value: go)    // << here !!
        }.navigationTitle("Animation Test")
    }
}

struct RectangleView: View {
    var body: some View {
        Rectangle()
            .frame(width: 100, height: 100)
            .foregroundColor(.pink)
            .overlay(TextView())
    }
}

struct TextView: View {
    @State private var animationRotating: Bool = false
    let animation = Animation.linear(duration: 3.0).repeatForever(autoreverses: false)
    
    var body: some View {
        Text("Test")
            .foregroundColor(.blue)
            .rotationEffect(.degrees(animationRotating ? 360 : 0))
            .animation(animation, value: animationRotating)          // << here !!
            .onAppear { animationRotating = true }
            .onDisappear { animationRotating = false }
    }
}
```
