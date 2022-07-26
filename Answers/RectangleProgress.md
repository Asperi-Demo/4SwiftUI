```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Rectangle progress bar swiftUI (by Johanna)

A: Here is simple demo of possible approach for [0..1] range progress indicator - 
trim path and animate progress state.

Updated: re-tested with Xcode 13.3 / iOS 15.4

![2tyRC](https://user-images.githubusercontent.com/62171579/166879467-afecc754-677e-4e2d-96b8-0520c0a6d474.gif)

```
struct ProgressBar: View {
    @Binding var progress: CGFloat // [0..1]

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .trim(from: 0.0, to: CGFloat(progress))
            .stroke(Color.red, lineWidth: 2.0)
            .animation(.linear, value: progress)
    }
}

struct DemoAnimatingProgress: View {
    @State private var progress = CGFloat.zero

    var body: some View {
        Button("Demo") {
            if self.progress == .zero {
                self.simulateLoading()
            } else {
                self.progress = 0
            }
        }
        .padding()
        .background(ProgressBar(progress: $progress))
    }

    func simulateLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.progress += 0.1
            if self.progress < 1.0 {
                self.simulateLoading()
            }
        }
    }
}
```
