>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Finding click location in SwiftUI on MacOS (by santi.gs)

A: Here is working variant

```
struct TappableView: NSViewRepresentable {

    var tappedCallback: ((CGPoint, Int) -> Void)

    func makeNSView(context: NSViewRepresentableContext<TappableView>) -> NSView {
        let v = NSView(frame: .zero)
        context.coordinator.configure(view: v)
        return v
    }

    class Coordinator: NSObject, NSGestureRecognizerDelegate {
        var tappedCallback: ((CGPoint, Int) -> Void)
        private var gesture: NSClickGestureRecognizer!
        private var gesture2: NSClickGestureRecognizer!

        init(tappedCallback: @escaping ((CGPoint, Int) -> Void)) {
            self.tappedCallback = tappedCallback
        }
        func configure(view: NSView) {
            gesture = NSClickGestureRecognizer(target: self, action: #selector(Coordinator.tapped))
            gesture.delegate = self
            gesture.numberOfClicksRequired = 1
            gesture2 = NSClickGestureRecognizer(target: self, action: #selector(Coordinator.doubleTapped))
            gesture2.delegate = self
            gesture2.numberOfClicksRequired = 2
            view.addGestureRecognizer(gesture)
            view.addGestureRecognizer(gesture2)
        }
        @objc func tapped(gesture:NSClickGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            self.tappedCallback(point, 1)
        }
        @objc func doubleTapped(gesture:NSClickGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            self.tappedCallback(point, 2)
        }

        func gestureRecognizer(_ gestureRecognizer: NSGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: NSGestureRecognizer) -> Bool {
            return gestureRecognizer === gesture && otherGestureRecognizer === gesture2
        }
    }

    func makeCoordinator() -> TappableView.Coordinator {
        return Coordinator(tappedCallback:self.tappedCallback)
    }

    func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<TappableView>) {
    }

}
```
