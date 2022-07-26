// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestProminentInsideStyle: View {
	var body: some View {
		ContentView().padding()
	}

	struct ContentView: View {
		var body: some View {
			Button("NO WAR") { print("HELP TO STOP russia!") }
				.buttonStyle(CustomButtonStyle(isEnabled: true))
		}
	}

	struct CustomButtonStyle: PrimitiveButtonStyle {
		let isEnabled: Bool
		func makeBody(configuration: Configuration) -> some View {
			Button(action: { configuration.trigger() }) {
				configuration.label
					.frame(maxWidth: .infinity)
			}
			.buttonStyle(.borderedProminent)
			.controlSize(.large)
			.tint(.accentColor)
			.foregroundColor(isEnabled ? .black : nil)
		}
	}
}

struct TestProminentInsideStyle_Previews: PreviewProvider {
	static var previews: some View {
		TestProminentInsideStyle()
	}
}
