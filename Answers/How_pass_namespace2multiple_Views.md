```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to pass @namespace to multiple Views in SwiftUI? (by Azhagusundaram Tamil)

A: The `@Namespace` is a wrapper for `Namespace.ID`, and you can pass `Namespace.ID` in argument to subviews.

Here is a demo of possible solution. Tested with Xcode 12 / iOS 14

```
struct HomeView: View {
    @Namespace var namespace
    @State var isDisplay = true

    var body: some View {
        ZStack {
            if isDisplay {
                View1(namespace: namespace, isDisplay: $isDisplay)
            } else {
                View2(namespace: namespace, isDisplay: $isDisplay)
            }
        }
    }
}

struct View1: View {
    let namespace: Namespace.ID
    @Binding var isDisplay: Bool
    var body: some View {
        VStack {
            Image("plant")
                .resizable()
                .frame(width: 150, height: 100)
                .matchedGeometryEffect(id: "img", in: namespace)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .onTapGesture {
            withAnimation {
                self.isDisplay.toggle()
            }
        }
    }
}

struct View2: View {
    let namespace: Namespace.ID
    @Binding var isDisplay: Bool
    var body: some View {
        VStack {
            Spacer()
            Image("plant")
                .resizable()
                .frame(width: 300, height: 200)
                .matchedGeometryEffect(id: "img", in: namespace)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation {
                self.isDisplay.toggle()
            }
        }
    }
}
```
