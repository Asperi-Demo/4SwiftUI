```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to use an NSAttributedString with a ScrollView in SwiftUI? (by sbdchd)

A: The reason is that SwiftUI `ScrollView` requires defined content size, but used `UITextView` is itself a `UIScrollView` and detects content based on available space in parent view. Thus it happens cycle of undefined sizes. 

Here is a simplified demo of possible approach how to solve this. The idea is to calculate content size of `UITextView` and pass it to SwiftUI...

    struct TextWithAttributedString: UIViewRepresentable {
        @Binding var height: CGFloat
        var attributedString: NSAttributedString
    
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView(frame: .zero)
            textView.isEditable = false
            return textView
        }
    
        func updateUIView(_ textView: UITextView, context: Context) {
            textView.attributedText = self.attributedString

            // calculate height based on main screen, but this might be 
            // improved for more generic cases
            DispatchQueue.main.async { // << fixed 
                height = textView.sizeThatFits(UIScreen.main.bounds.size).height
            }
        }
    }
    
    
    struct NSAttributedStringView: View {
        @State private var textHeight: CGFloat = .zero
        var body: some View {
            ScrollView {
                TextWithAttributedString(height: $textHeight, attributedString: NSAttributedString(string: exampleText))
                    .frame(height: textHeight) // << specify height explicitly !
            }
        }
    }

