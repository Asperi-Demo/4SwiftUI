// BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestTextFieldActivationEffect: View {
	@State private var txt = ""
	var body: some View {
		VStack(spacing: 20) {
			TextField("", text: $txt)
			ContentView()
		}
	}
	
	struct ContentView: View {
		@State private var text = "Github"
		@FocusState private var highlight
		
		var body: some View {
			TextField("Placeholder", text: $text)
				.focused($highlight)
				.textFieldStyle(PlainTextFieldStyle()).padding(8)
				.background(
					RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(0.2))
						.overlay(VStack {
							if highlight {
								Rectangle().fill(.blue)
									.frame(height: 2)
									.transition(.scale)
							}
						}.animation(.default, value: highlight), alignment: .bottom))
				.clipShape(RoundedRectangle(cornerRadius: 8))
				.frame(width: 200)
		}
	}
}

struct TestTextEditActivation_Previews: PreviewProvider {
	static var previews: some View {
		TestTextFieldActivationEffect()
	}
}
