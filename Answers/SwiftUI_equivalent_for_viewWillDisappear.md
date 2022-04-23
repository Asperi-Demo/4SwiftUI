```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Is there a SwiftUI equivalent for viewWillDisappear(_:) or detect when a view is about to be removed? (by )

A: Here is approach that works for me, it is not pure-SwiftUI but I assume worth posting

Usage:

       SomeView()
       .onDisappear {
            print("x Default disappear")
        }
       .onWillDisappear { // << order does NOT matter
            print(">>> going to disappear")
        }

Code:

    struct WillDisappearHandler: UIViewControllerRepresentable {
        func makeCoordinator() -> WillDisappearHandler.Coordinator {
            Coordinator(onWillDisappear: onWillDisappear)
        }
    
        let onWillDisappear: () -> Void
    
        func makeUIViewController(context: UIViewControllerRepresentableContext<WillDisappearHandler>) -> UIViewController {
            context.coordinator
        }
    
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<WillDisappearHandler>) {
        }
    
        typealias UIViewControllerType = UIViewController
    
        class Coordinator: UIViewController {
            let onWillDisappear: () -> Void
    
            init(onWillDisappear: @escaping () -> Void) {
                self.onWillDisappear = onWillDisappear
                super.init(nibName: nil, bundle: nil)
            }
    
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
    
            override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(animated)
                onWillDisappear()
            }
        }
    }
    
    struct WillDisappearModifier: ViewModifier {
        let callback: () -> Void
    
        func body(content: Content) -> some View {
            content
                .background(WillDisappearHandler(onWillDisappear: callback))
        }
    }
    
    extension View {
        func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
            self.modifier(WillDisappearModifier(callback: perform))
        }
    }



