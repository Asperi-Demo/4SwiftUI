```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: reuse code/properties for several views in swiftui (by memical)

A: The `.presentationMode` is available throughout current view hierarchy, so we can use this feature to wrap & manage dismiss in some modifier.

Here is a demo of solution based on button style, so any button can be specified as dismissing and it will dismiss current presentation.

Prepared with Xcode 12.1 / iOS 14.1

![MtLVF](https://user-images.githubusercontent.com/62171579/176440819-e7cdc4ea-1175-496d-a11f-b0eba7eb919c.gif)

```
struct TestReuseDismissed: View {
	@State private var isActive = false
	var body: some View {
		Button("Show Sheet") {
			isActive = true
		}
		.sheet(isPresented: $isActive) {
			Button("Dismiss", action: { 
                   // do something before dismiss here !!
                })
				.buttonStyle(DismissButtonStyle())
		}
	}
}

struct DismissButtonStyle: PrimitiveButtonStyle {
	@Environment(\.presentationMode) var presentationMode

	func makeBody(configuration: Configuration) -> some View {
		Button(action: {
			configuration.trigger()
			dismiss()
		}) { configuration.label }
	}

	func dismiss() {
		presentationMode.wrappedValue.dismiss()
	}
}
```
