// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTextWithURL: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		@Environment(\.openURL) var openURL
		var body: some View {
			Text("here is a phone: [xxx-xxx-xxxx](tel:xxx-xxx-xxxx) and here is a link: [xxx.com](asperi://apple.com). Go for it.")
				.onOpenURL {
					print(">> got: \($0)")
					print("preprocess & forward")
					if let host = $0.host, let url = URL(string: "https://" + host) {
						openURL(url)
					}
				}
		}
	}
}

struct TestTextWithURL_Previews: PreviewProvider {
	static var previews: some View {
		TestTextWithURL()
	}
}
