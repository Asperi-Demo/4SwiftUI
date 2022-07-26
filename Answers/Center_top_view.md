```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Center SwiftUI view in top-level view (by Dávid Pásztor)

A: Here is a demo of possible approach. The idea is to use injected UIView to access UIWindow and then show loading view as a top view of window's root viewcontroller view.

Tested with Xcode 12 / iOS 14 (but SwiftUI 1.0 compatible)

![4fjmh](https://user-images.githubusercontent.com/62171579/170984157-68516f40-31b5-4201-a6ed-c0525a1d63db.gif)

*Note: animations, effects, etc. are possible but are out scope for simplicity*

```
struct CenteredLoadingView<RootView: View>: View {
    private let rootView: RootView
    @Binding var isActive: Bool

    init(rootView: RootView, isActive: Binding<Bool>) {
        self.rootView = rootView
        self._isActive = isActive
    }

    var body: some View {
        rootView
            .background(Activator(showLoading: $isActive))
    }

    struct Activator: UIViewRepresentable {
        @Binding var showLoading: Bool
        @State private var myWindow: UIWindow? = nil

        func makeUIView(context: Context) -> UIView {
            let view = UIView()
            DispatchQueue.main.async {
                self.myWindow = view.window
            }
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {
            guard let holder = myWindow?.rootViewController?.view else { return }

            if showLoading && context.coordinator.controller == nil {
                context.coordinator.controller = UIHostingController(rootView: loadingView)

                let view = context.coordinator.controller!.view
                view?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
                view?.translatesAutoresizingMaskIntoConstraints = false
                holder.addSubview(view!)
                holder.isUserInteractionEnabled = false

                view?.leadingAnchor.constraint(equalTo: holder.leadingAnchor).isActive = true
                view?.trailingAnchor.constraint(equalTo: holder.trailingAnchor).isActive = true
                view?.topAnchor.constraint(equalTo: holder.topAnchor).isActive = true
                view?.bottomAnchor.constraint(equalTo: holder.bottomAnchor).isActive = true
            } else if !showLoading {
                context.coordinator.controller?.view.removeFromSuperview()
                context.coordinator.controller = nil
                holder.isUserInteractionEnabled = true
            }
        }

        func makeCoordinator() -> Coordinator {
            Coordinator()
        }

        class Coordinator {
            var controller: UIViewController? = nil
        }

        private var loadingView: some View {
            VStack {
                Color.white
                    .frame(width: 48, height: 72)
                Text("Loading")
                    .foregroundColor(.white)
            }
                .frame(width: 142, height: 142)
                .background(Color.primary.opacity(0.7))
                .cornerRadius(10)
        }
    }
}

struct CenterView: View {
    @State private var isLoading = false
    var body: some View {
        return VStack {
            Color.gray
            HStack {
                CenteredLoadingView(rootView: list, isActive: $isLoading)
                otherList
            }
            Button("Demo", action: load)
        }
        .onAppear(perform: load)
    }

    func load() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
        }
    }

    var list: some View {
        List {
            ForEach(1..<6) {
                Text($0.description)
            }
        }
    }

    var otherList: some View {
        List {
            ForEach(6..<11) {
                Text($0.description)
            }
        }
    }
}
```
