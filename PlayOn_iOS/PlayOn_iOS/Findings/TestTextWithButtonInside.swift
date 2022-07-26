// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTextWithButtonInside: View {
	@State private var isDetails = false

	var body: some View {
		HStack(alignment: .top) {
			Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.yellow)

			// place link with custom key...
			Text("All your information are confidential. For more information please refer to [here](conf_info)")
		}
		.environment(\.openURL, OpenURLAction { url in
			if url == URL(string: "conf_info") { // << intercept key
				showDetails()
				return .handled
			}
			return .systemAction
		})
		.sheet(isPresented: $isDetails) {
			Text("Details are here")
		}
	}

	private func showDetails() {
		// whatever needed
		isDetails = true
	}
}

struct TestTextWithButtonInside_Previews: PreviewProvider {
    static var previews: some View {
        TestTextWithButtonInside()
    }
}
