```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - how to pulsate image opacity? (by Gerard)

A: Here is an approach. Tested with Xcode 11.4 / iOS 13.4

![H5Dwv](https://user-images.githubusercontent.com/62171579/168856275-b8bdfc7c-c486-47f3-a06a-4e7330c30dd0.gif)

```
struct DemoImagePulsate: View {
    @State private var value = 1.0
    var body: some View {
        Image(systemName: "dot.radiowaves.left.and.right" )
            .foregroundColor(.blue)
            .opacity(value)
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
        .onAppear { self.value = 0.3 }
    }
}
```
