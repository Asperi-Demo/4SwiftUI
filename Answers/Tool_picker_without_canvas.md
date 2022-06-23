```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Using PKToolPicker without PKCanvasView (by Arshia)

A: Here is simplest demo to show PKToolPicker for any custom UIView in SwiftUI.

Tested with Xcode 11.4 / iOS 13.4

![IgN2s](https://user-images.githubusercontent.com/62171579/175239730-663a6826-f19c-4903-9674-c8a1856913cc.gif)

```
struct ToolPickerDemo: View {
    @State private var showPicker = false
    var body: some View {
        Button("Picker") { self.showPicker.toggle() }
            .background(ToolPickerHelper(isActive: $showPicker))
    }
}

class PickerHelperView: UIView {
    override var canBecomeFirstResponder: Bool { true }
}

struct ToolPickerHelper: UIViewRepresentable {
    @Binding var isActive: Bool

    func makeUIView(context: Context) -> PickerHelperView {
        PickerHelperView()
    }

    func updateUIView(_ uiView: PickerHelperView, context: Context) {
        guard let window = uiView.window else { return }

        let picker = PKToolPicker.shared(for: window)
        picker?.setVisible(isActive, forFirstResponder: uiView)

        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
        }
    }
}
```
