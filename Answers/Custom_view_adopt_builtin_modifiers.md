```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Making a custom SwiftUI View adapt to built-in modifiers (by Extragorey)

A: `View` modifiers are just functions that just return again `some View`, so you can implement support for any modifier, conforming to any protocol you decide appropriate to your custom type. How your control would behave on each implemented modifier is up to you.

Below is a simple demo support for `textFieldStyle` modifier that makes your `ContentView` render `BetterTextField` as intended depending on added round rect style modifier or removed.


    struct BetterTextField: UIViewRepresentable {
        var title: String
        @Binding var text: String
    
        private let textField = UITextField()
    
        init(_ title: String, text: Binding<String>) {
            self.title = title
            self._text = text
        }
    
        func makeUIView(context: Context) -> UITextField {
            textField.placeholder = title
            return textField
        }
    
        func updateUIView(_ view: UITextField, context: Context) {
            view.text = text
        }
    }
    
    extension BetterTextField {
        func textFieldStyle<S>(_ style: S) -> some View where S : TextFieldStyle {
            if style is RoundedBorderTextFieldStyle {
                self.textField.borderStyle = .roundedRect
            }
            return self
        }
    }

