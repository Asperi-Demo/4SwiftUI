>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to animate tabbar items (on selection) in SwiftUI? (by Mehdi)

A: (works till iOS 15)

Here is possible approach for standard `TabView` (for provided code snapshot). 

The idea is to use animatable modifier for font size over used SF images.

Tested with Xcode 11.4 / iOS 13.4

![71J0L](https://user-images.githubusercontent.com/62171579/182080751-21914514-c972-4b72-b022-5e0abcf06ddc.gif)

```
// Animating font size
struct AnimatableSFImage: AnimatableModifier {
    var size: CGFloat

    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }

    func body(content: Self.Content) -> some View {
        content
            .font(.system(size: size))
    }
}

// helper extension
extension Image {
    func animatingSF(size: CGFloat) -> some View {
        self.modifier(AnimatableSFImage(size: size))
    }
}

// Modified test code snapshot
struct TestAnimatedTabBar: View {
    @State var enlargeIt1 = false
    @State var enlargeIt2 = true

    var body: some View {
        TabView {
            Text("Item 1")
                .onAppear {
                    self.enlargeIt1.toggle()
                    self.enlargeIt2.toggle()
                }
                .tabItem{
                    VStack{
                        Image(systemName: "music.note")
                            .animatingSF(size: self.enlargeIt1 ? 30 : 15 )
                        Text("Music")
                    }.animation(.interpolatingSpring(mass: 0.7, 
             stiffness: 200, damping: 10, initialVelocity: 4))
                }.tag(1)

            Text("Item 2")
                .onAppear {
                    self.enlargeIt1.toggle()
                    self.enlargeIt2.toggle()
                }
                .tabItem{
                    VStack{
                        Image(systemName: "music.mic")
                            .animatingSF(size: self.enlargeIt2 ? 30 : 15 )
                        Text("Mic")
                    }.animation(.interpolatingSpring(mass: 0.7, 
             stiffness: 200, damping: 10, initialVelocity: 4))
                }.tag(2)

        }
    }
}
```
