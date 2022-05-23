// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestTextFiledFocusOnLaunch: View {
	@State var disabled: Bool = true
	@State private var txt = ""
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			TextField("", text: $txt).disabled(disabled)
				.onAppear { DispatchQueue.main.async { disabled = false } }
		}.padding(.horizontal)
	}
}

struct TestTextFiledFocusOnLaunch_Previews: PreviewProvider {
	static var previews: some View {
		TestTextFiledFocusOnLaunch()
	}
}
