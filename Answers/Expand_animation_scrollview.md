```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI animation/transition within scrollview behaving strange (by Tamás Horváth)

A: Here is possible solution - defer set `ScrollView` content animation until after content has initially constructed 
in parent. Read also comments inline. Tested with Xcode 11.4 / iSO 13.4

![kfg47](https://user-images.githubusercontent.com/62171579/179524339-24d2dc0b-d572-45a9-8150-a30cc4d3cb9a.gif)

```
struct ExpandingView: View {

    @State var showContent = false

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                        self.showContent.toggle()
                }) {
                    Image(systemName: "chevron.right.circle")
                }
                Text("TITLE")
                    .padding(.leading, 10)
                Spacer()
            }
            if showContent {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras volutpat dapibus ante eget laoreet. Aenean lacus elit, auctor ut nisl id, fermentum pretium mi. Quisque lacus nisl, suscipit hendrerit est sed, congue dictum augue. Suspendisse semper viverra accumsan. Maecenas commodo turpis convallis nisl bibendum pharetra.")
                    .fixedSize(horizontal: false, vertical: true)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}

struct DemoExpandingView: View {

    // initial nil to avoid initial animation
    @State private var animation: Animation? = nil
    var body: some View {
        ScrollView {
            VStack {
                ExpandingView()
                ExpandingView()
                ExpandingView()
                Text("Some static text")
            }.animation(animation) // << needed to animate static section
        }
        .onAppear {
            DispatchQueue.main.async {
                // assign in-container animation `after` container rendered
                self.animation = .default
            }
        }
    }
}
```
