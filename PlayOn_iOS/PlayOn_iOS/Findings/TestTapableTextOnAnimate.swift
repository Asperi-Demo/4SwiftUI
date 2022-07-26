// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTapableTextOnAnimate: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@State var offsetY : CGFloat = 0
		var body: some View {
			VStack {
				Text("Animate")
					.onTapGesture {
						withAnimation(.linear(duration: 15)){
							offsetY = 200
						}
					}
				Text("Hello, world!")
					.onTapGesture {
						print("Tap")
					}
					.modifier(MovableViewModifier(value: offsetY))
			}
		}

		struct MovableViewModifier: AnimatableModifier {
			var value: CGFloat

			var animatableData: CGFloat {
				get { value }
				set { value = newValue }
			}

			func body(content: Content) -> some View {
				content.offset(y: value)
			}
		}

	}
}

struct TestTapableTextOnAnimate_Previews: PreviewProvider {
	static var previews: some View {
		TestTapableTextOnAnimate()
	}
}
