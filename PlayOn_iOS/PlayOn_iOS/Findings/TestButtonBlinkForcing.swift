// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestButtonBlinkForcing: View {
	@State  var blink = false
	var body: some View {
		VStack {
			Button(action: { self.blink = true }) {
				Text("Force Blinking")
			}
			Divider()
			Text("STOP russia!").foregroundColor(.red).padding()
				.blinkBorder(on: $blink, color: Color.yellow, repeatCount: 5, duration: 0.5)
		}
		.onAppear {
			self.blink = true
		}
	}
}

struct TestButtonBlinkForcing_Previews: PreviewProvider {
	static var previews: some View {
		TestButtonBlinkForcing()
	}
}

// MARK: -
struct BlinkingBorderModifier: ViewModifier {
	let state: Binding<Bool>
	let color: Color
	let repeatCount: Int
	let duration: Double

	// internal wrapper is needed because there is no didFinish of Animation now
	private var blinking: Binding<Bool> {
		Binding<Bool>(get: {
			DispatchQueue.main.asyncAfter(deadline: .now() + self.duration) {
				self.state.wrappedValue = false
			}
			return self.state.wrappedValue }, set: {
				self.state.wrappedValue = $0
			})
	}

	func body(content: Content) -> some View
	{
		content
			.border(self.blinking.wrappedValue ? self.color : Color.blue, width: 3.0)
			.animation( // Kind of animation can be changed per needs
				Animation.linear(duration:self.duration).repeatCount(self.repeatCount)
				, value: blinking.wrappedValue)
	}
}

extension View {
	func blinkBorder(on state: Binding<Bool>, color: Color,
					 repeatCount: Int = 1, duration: Double = 0.5) -> some View {
		self.modifier(BlinkingBorderModifier(state: state, color: color,
											 repeatCount: repeatCount, duration: duration))
	}
}
