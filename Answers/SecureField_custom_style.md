```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI textfield color (by )

A: Find below a demo of some possible approach. Also might worth considering representable around `UITextField` as it is much more configurable.

Tested with Xcode 11.7 / iOS 13.7

![4yi9z](https://user-images.githubusercontent.com/62171579/176422741-9c632bce-0ac6-4155-9492-31463c6d9e74.gif)

```
struct PlaceholderTextFieldStyle: TextFieldStyle {
	let placeholder: String
	@Binding var text: String

	init(_ placeholder: String, text: Binding<String>) {
		self.placeholder = placeholder
		self._text = text
	}

	func _body(configuration: TextField<Self._Label>) -> some View {
		ZStack {
			if text.isEmpty {
				Text(placeholder)
			}
			configuration
		}.foregroundColor(.white)
	}
}

struct DemoView: View {
	@State private var pass = ""

    var body: some View {
        SecureField("", text: $pass)
        .textFieldStyle(PlaceholderTextFieldStyle("Password", text: $pass))
        .padding(.all).border(Color.white).cornerRadius(3.0).padding(.horizontal)
        .padding()
        .background(Color.blue)

    }
}
```
