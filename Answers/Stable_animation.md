```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Having trouble creating a star animation in swiftUI (by user768861)

A: To have animation activated you need to *toggle* some values, so animator has range to animate in between.

Here is fixed code. Tested with Xcode 12 / iOS 14.

![OJdLP](https://user-images.githubusercontent.com/62171579/179243029-3a7b1f2e-ab25-4a12-873c-b69ae56dd3b5.gif)

```
struct ContentView: View {
    @State private var run = false    // << here !!

    private var opacity = 0.25
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack  {
                ForEach(0..<8) {_ in
                HStack {
                    ForEach(0..<5) { _ in
                        Circle().fill(Color.white)
                        .frame(width: 3, height: 3)
                        .blur(radius: run ? 4 : 2)     // << here !!
                        .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true))
                        .padding(EdgeInsets(top: self.calculateRandom(), leading: 0,
                       bottom: 0, trailing: self.calculateRandom()))
                        .onAppear() {
                            self.run = true     // << here !!
                        }
                }
                }
            }
            }


        }
    }

    func calculateRandom() -> CGFloat {
        return CGFloat(Int.random(in: 30..<150))
    }
}
```

**Update:** variant with static *star* positions (movement animation is caused by layout in V/H/Stacks as soon as new elements added, so to avoid this it needs to remove those inner stacks and layout manually in ZStack with `.position` modifier)

![YdcnZ](https://user-images.githubusercontent.com/62171579/179243052-31046841-939e-42a5-a71a-4e2b184ff9da.gif)

```
struct BlurContentView: View {
    @State private var run = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            GeometryReader { gp in
                ForEach(0..<8) {_ in
                    ForEach(0..<5) { _ in
                        Circle().fill(Color.white)
                            .frame(width: 3, height: 3)
                            .position(x: calculateRandom(in: gp.size.width),
                                      y: calculateRandom(in: gp.size.height))
                            .animation(nil)     // << no animation for above modifiers
                            .blur(radius: run ? 4 : 2)
                        
                    }
                }
            }
            .animation(Animation.easeInOut(duration: 6)
                .repeatForever(autoreverses: true), value: run) // animate one value
            .onAppear() {
                self.run = true
            }
        }
    }
    
    func calculateRandom(in value: CGFloat) -> CGFloat {
        return CGFloat(Int.random(in: 10..<Int(value) - 10))
    }
}
```
