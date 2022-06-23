```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Disable scrolling upwards in UITextView in SwiftUI (by Adam Strike)

A: It can be done with simple subclass of `UITextView` to handle pan gesture activation.

Tested with Xcode 12

![k7LPh](https://user-images.githubusercontent.com/62171579/175346053-7f1c5da9-b2df-47cb-ac44-beac8eacc197.gif)

```
class BottomScrollTextView: UITextView {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let gr = gestureRecognizer as? UIPanGestureRecognizer else { return true }

        return gr.translation(in: self).y < 0    // << allow only to down
    }

    private var _contentOffset = CGPoint.zero
    override var contentOffset: CGPoint {
        get { super.contentOffset }
        set {
            if newValue.y > super.contentOffset.y || self.isDecelerating {
                super.contentOffset = newValue
            }
        }
    }
}

struct TextView: UIViewRepresentable {

    typealias UIViewType = UITextView
    var configuration = { (view: UIViewType) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        let view = BottomScrollTextView()   // << here !!

        // ... other code

```
