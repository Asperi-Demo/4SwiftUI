```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to stop SwiftUI DragGesture from animating subviews (by )

A: Theoretically SwiftUI should not translate animation in this case, however I'm not sure if this is a bug - I would not use animation in Container in that generic way. The more I use animations the more tend to join them directly to specific values. 

Anyway... here is possible workaround - break animation visibility by injecting different hosting controller in a middle.

Tested with Xcode 12 / iOS 14

![okMM4](https://user-images.githubusercontent.com/62171579/174061977-b8921a5c-f38c-45ff-8dfa-f6a310f047d2.gif)

```
struct ViewOverlay<Presenting>: View where Presenting: View {
    @Binding var isShowing: Bool
    
    let presenting: () -> Presenting
    
    @State var bottomState: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .center) {
            presenting().blur(radius: isShowing ? 1 : 0)
            VStack {
          Color.clear
                if isShowing {
            HelperView {
                    Container()
                        .background(Color.red)
            }
            .offset(y: bottomState)
            .gesture(
               DragGesture()
                  .onChanged { value in
                    bottomState = value.translation.height
                  }
                  .onEnded { _ in
                    if bottomState > 50 {
                       withAnimation {
                          isShowing = false
                       }
                    }
                    bottomState = 0
                  })
            .transition(.move(edge: .bottom))
                }
          Color.clear
            }
        }
    }
}

struct HelperView<Content: View>: UIViewRepresentable {
  let content: () -> Content
  func makeUIView(context: Context) -> UIView {
    let controller = UIHostingController(rootView: content())
    return controller.view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
  }
}
```
