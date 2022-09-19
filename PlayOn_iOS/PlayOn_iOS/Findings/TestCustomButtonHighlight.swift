// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomButtonHighlight: View {
	@State private var highlighted = false
	
	var body: some View {
		VStack {
			Button("My Button", action: doSomething)
				.highlighted(highlighted)
			Divider()
			Button("Toggle highlight") {
				self.highlighted.toggle()
			}
		}
	}
	
	func doSomething() { }
}

fileprivate extension Button {
	struct HighlightButtonStyle: ButtonStyle {
		let highlighted: Bool

		func makeBody(configuration: Configuration) -> some View {
			configuration.label
				.background(highlighted || configuration.isPressed ? Color.yellow : Color.clear)
		}
	}

	func highlighted(_ flag: Bool) -> some View {
		self.buttonStyle(HighlightButtonStyle(highlighted: flag))
	}
}

struct TestCustomButtonHighlight_Previews: PreviewProvider {
	static var previews: some View {
		TestCustomButtonHighlight()
	}
}
