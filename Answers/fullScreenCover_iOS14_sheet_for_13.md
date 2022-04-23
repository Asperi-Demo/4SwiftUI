```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to use fullScreenCover with iOS 14 but sheet for 13 (by Jordan H)

A: It is possible to solve by custom modifier that branches conditionally `fullScreenCover` for SwiftUI2+
and anything applicable (eg, `sheet` in this case) for older OS versions.

Here is possible approach

```
struct DemoCompatibleFullScreen: View {
    @State private var activateFullScreen = false
    var body: some View {
        Button("Toggle") { self.activateFullScreen.toggle() }
            .compatibleFullScreen(isPresented: $activateFullScreen) {
                Text("I'm in Full Screen!")
            }
    }
}

extension View {
    func compatibleFullScreen<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(FullScreenModifier(isPresented: isPresented, builder: content))
    }
}

struct FullScreenModifier<V: View>: ViewModifier {
    let isPresented: Binding<Bool>
    let builder: () -> V

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content.fullScreenCover(isPresented: isPresented, content: builder)
        } else {
            content.sheet(isPresented: isPresented, content: builder)
        }
    }
}
```
[Extension in project here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Extensions/View%2B.swift)
