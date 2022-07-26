```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: "Generic parameter could not be inferred" in SwiftUI UIViewRepresentable (by Bart van Kuik)

A: Here is possible approach that allows usage of provided `ContentView` as-is. 

Just change the direction of... instead of making entire type generic, which is actually not needed in this case, just make a generic only initialisation, like below.

Also it actually makes clear that `Action` is Content-independent, that is really correct.

Tested & works with Xcode 11.2 / iOS 13.2 (w/o no changes in `ContentView`)

    struct LegacyScrollView: UIViewRepresentable {
        enum Action {
            case idle
            case offset(x: CGFloat, y: CGFloat, animated: Bool)
        }
    
        @Binding var action: Action
        private let uiScrollView: UIScrollView
    
        init<Content: View>(content: Content) {
            let hosting = UIHostingController(rootView: content)
            hosting.view.translatesAutoresizingMaskIntoConstraints = false
    
            uiScrollView = UIScrollView()
            uiScrollView.addSubview(hosting.view)
    
            let constraints = [
                hosting.view.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor),
                hosting.view.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor),
                hosting.view.topAnchor.constraint(equalTo: uiScrollView.contentLayoutGuide.topAnchor),
                hosting.view.bottomAnchor.constraint(equalTo: uiScrollView.contentLayoutGuide.bottomAnchor),
                hosting.view.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor)
            ]
            uiScrollView.addConstraints(constraints)
    
            self._action = Binding.constant(Action.idle)
        }
    
        init<Content: View>(@ViewBuilder content: () -> Content) {
            self.init(content: content())
        }
    
        init<Content: View>(action: Binding<Action>, @ViewBuilder content: () -> Content) {
            self.init(content: content())
            self._action = action
        }
    
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    
        func makeUIView(context: Context) -> UIScrollView {
            return uiScrollView
        }
    
        func updateUIView(_ uiView: UIScrollView, context: Context) {
            switch self.action {
            case .offset(let x, let y, let animated):
                uiView.setContentOffset(CGPoint(x: x, y: y), animated: animated)
                DispatchQueue.main.async {
                    self.action = .idle
                }
            default:
                break
            }
        }
    
        class Coordinator: NSObject {
            let legacyScrollView: LegacyScrollView
    
            init(_ legacyScrollView: LegacyScrollView) {
                self.legacyScrollView = legacyScrollView
            }
        }
    
    }

 
