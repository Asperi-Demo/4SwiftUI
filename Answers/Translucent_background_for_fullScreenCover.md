```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
       on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Translucent background for fullScreenCover (by Son Nguyen)

A: Here is a demo of possible way. Parameters of visual effect you can tune for your needs.

Tested with Xcode 12 / iOS 14.


```
     // ... other code
      .fullScreenCover(isPresented: $isLoading) {
        ZStack{
          Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
          VStack {
            ProgressView()
            Button("Stop loading") {
              isLoading.toggle()
            }
          }
        }
        .background(BackgroundBlurView())
      }
    }
  }
}

struct BackgroundBlurView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .clear
    }
    return view
  }

  func updateUIView(_ uiView: UIView, context: Context) {}
}
```
