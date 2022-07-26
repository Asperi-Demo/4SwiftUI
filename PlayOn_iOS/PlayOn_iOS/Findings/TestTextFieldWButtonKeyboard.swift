// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTextFieldWButtonKeyboard: View {
	@State private var text = ""
	@FocusState private var focused: Bool

	var body: some View {
		ScrollViewReader { sr in
			ScrollView {
				VStack {
					Text("Long content here")
						.frame(maxWidth: .infinity, minHeight: 800)
						.background(.yellow)
					TextField("Placeholder", text: $text)
						.focused($focused)
					Button("Submit") { }
						.padding()    // << for better visibility
						.id("submit")
				}
			}
			.onChange(of: focused) {
				if $0 {
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {    // << !!
						withAnimation {  // << same default animation
							sr.scrollTo("submit", anchor: .bottom)
						}
					}
				}
			}
		}
	}
}

struct TestTextFieldWButtonKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        TestTextFieldWButtonKeyboard()
    }
}
