// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestTextFieldActivationEffect: View {
	@State private var txt = ""
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
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
				.onChange(of: highlight) {  // handle selection on focus
					if $0 {
						// need a bit of time while NSWindow's TextEditor is created
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
							NSApp.sendAction(#selector(NSText.selectAll(_:)), to: nil, from: nil)

						}
					}
				}
		}
	}
}

struct TestTextEditActivation_Previews: PreviewProvider {
	static var previews: some View {
		TestTextFieldActivationEffect()
	}
}
