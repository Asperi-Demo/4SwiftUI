```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q; How do I create a Multi Line Text Field in SwiftUI for MacOS? (by Manngo)

A: Here is some initial demo of component like iOS14 TextEditor. 

Demo prepared & tested with Xcode 11.7 / macOS 10.15.6

![nITU1](https://user-images.githubusercontent.com/62171579/169692205-a1400a4a-f8e6-42cc-b8e5-b6cc6656ef94.gif)

```
struct TestTextArea: View {
    @State private var text = "Placeholder: Enter some text"

    var body: some View {
        VStack {
            TextArea(text: $text)
                .border(Color.black)
//            Text(text) // uncomment to see mirror of enterred text
        }.padding()
    }
}

struct TextArea: NSViewRepresentable {
    @Binding var text: String

    func makeNSView(context: Context) -> NSScrollView {
        context.coordinator.createTextViewStack()
    }

    func updateNSView(_ nsView: NSScrollView, context: Context) {
        if let textArea = nsView.documentView as? NSTextView, textArea.string != self.text {
            textArea.string = self.text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var text: Binding<String>

        init(text: Binding<String>) {
            self.text = text
        }

        func textView(_ textView: NSTextView, shouldChangeTextIn range: NSRange, replacementString text: String?) -> Bool {
            defer {
                self.text.wrappedValue = (textView.string as NSString).replacingCharacters(in: range, with: text!)
            }
            return true
        }

        fileprivate lazy var textStorage = NSTextStorage()
        fileprivate lazy var layoutManager = NSLayoutManager()
        fileprivate lazy var textContainer = NSTextContainer()
        fileprivate lazy var textView: NSTextView = NSTextView(frame: CGRect(), textContainer: textContainer)
        fileprivate lazy var scrollview = NSScrollView()

        func createTextViewStack() -> NSScrollView {
            let contentSize = scrollview.contentSize

            textContainer.containerSize = CGSize(width: contentSize.width, height: CGFloat.greatestFiniteMagnitude)
            textContainer.widthTracksTextView = true

            textView.minSize = CGSize(width: 0, height: 0)
            textView.maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            textView.isVerticallyResizable = true
            textView.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
            textView.autoresizingMask = [.width]
            textView.delegate = self

            scrollview.borderType = .noBorder
            scrollview.hasVerticalScroller = true
            scrollview.documentView = textView

            textStorage.addLayoutManager(layoutManager)
            layoutManager.addTextContainer(textContainer)

            return scrollview
        }
    }
}
```
