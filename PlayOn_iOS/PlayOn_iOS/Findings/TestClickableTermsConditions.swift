// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestClickableTermsConditions: View {
	@State private var accepted = false
	@State private var showText = false

	var body: some View {
		TermsConditionsView(accepted: $accepted) {
			// show Terms and conditions here
			showText = true
		}
		.sheet(isPresented: $showText) {
			Text(Lorem.short).bold().padding()
			Text(Lorem.original).padding()
		}
	}

	struct TermsConditionsView: View {
		@Environment(\.openURL) private var openURL

		@Binding var accepted: Bool
		var wantRead: () -> ()

		var body: some View {
			HStack(alignment: .top) {
				Image(systemName: accepted ? "checkmark.square" : "square")
					.resizable().frame(width: 24, height: 24)
					.foregroundColor(.orange)
					.onTapGesture { accepted.toggle() }
				
				Text("I have read and agree to the [Terms and Conditions](terms_action)")
					.environment(\.openURL, OpenURLAction {
						guard $0.absoluteString == "terms_action" else {
							return .discarded
						}
						print("Read >> \($0)")
						wantRead()
						return .handled
					})
					.tint(.orange)
				
				Spacer()
			}
			.padding(.horizontal)
		}
	}
	
}

struct TestClickableTermsConditions_Previews: PreviewProvider {
	static var previews: some View {
		TestClickableTermsConditions()
	}
}
