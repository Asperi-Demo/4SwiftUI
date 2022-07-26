// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestRenewAsyncImageResult: View {
	var body: some View {
		ContentView()
	}
	
	struct ContentView: View {
		@State private var backgroundImgUrl = "https://source.unsplash.com/1600x900/?nature&\(Int.random(in: 1..<6236))"
		var body: some View {
			AsyncImage(url: URL(string: backgroundImgUrl)) { phase in
				switch phase {
				case .empty:
					Color.purple.opacity(0.1)
				case .success(let image):
					image
						.ignoresSafeArea()
						.scaledToFit()
						.onAppear {
							//code here happen for 1 time only even for every background change
							print(">> appeary for \(backgroundImgUrl)")
						}.id(backgroundImgUrl)
					//can I execute code here??? syntax error happens
				case .failure(_):
					Image(systemName: "exclamationmark.icloud")
						.resizable()
						.scaledToFit()
				@unknown default:
					Image(systemName: "exclamationmark.icloud")
				}
			}
			.onTapGesture {
				backgroundImgUrl = "https://source.unsplash.com/1600x900/?nature&\(Int.random(in: 1..<6236))"

			}
		}
	}
}

struct TestRenewAsyncImageResult_Previews: PreviewProvider {
	static var previews: some View {
		TestRenewAsyncImageResult()
	}
}
