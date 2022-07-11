```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Create a view over navigationView, SwiftUI (by manubrio)

A: Here is a demo of possible approach (it can be added animations/transitions, but it is out of topic). Demo prepared & tested with Xcode 11.4 / iOS 13.4

![koBiU](https://user-images.githubusercontent.com/62171579/178194952-0b2c6113-3edf-45c4-8de5-749228213150.gif)

```
struct ShowViewModifier<Cover: View>: ViewModifier {
    let show: Bool
    let cover: () -> Cover

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            if self.show {
                cover()
            }
        }
    }
}

struct DemoView: View {
    @State private var isPresented = false
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Link", destination: Button("Details")
                    { self.isPresented.toggle() })
                Text("Some content")
                    .navigationBarTitle("Demo")
                Button("Toggle") { self.isPresented.toggle() }
            }
        }
        .modifier(ShowViewModifier(show: isPresented) {
            Rectangle().fill(Color.red)
                .frame(height: 200)
        })
    }
}

```
