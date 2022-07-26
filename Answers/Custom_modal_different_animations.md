```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to present a modal view controller like with UIKit's UIViewControllerTransitioningDelegate?

A: Well there is no built-in such flexibility say with standard .sheet, but it can be implemented custom very fast.

Here is simple demo (Xcode 13.3 / iOS 15.4)

![ezgif com-gif-maker-62](https://user-images.githubusercontent.com/62171579/168882802-0b9506ae-e62e-4929-956d-eee8aa661f8c.gif)

Main part:

```
struct ElementsList: View {
// ...
		ModalView(isPresented: $isModal) {
			List(elements, id: \.self) {


struct ModalView<V: View>: View {
    @Binding var isPresented: Bool
// ...
		ZStack {
			content()
			ZStack {
				VStack {
					if isPresented {
						Color.black.opacity(0.8)
							.transition(.opacity)
					}
				}.animation(.easeInOut(duration: 0.25), value: isPresented)


```

[Complete test code in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestCustomModal.swift) 
