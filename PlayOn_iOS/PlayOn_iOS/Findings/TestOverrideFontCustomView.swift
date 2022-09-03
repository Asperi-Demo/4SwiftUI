// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestOverrideFontCustomView: View {
	var body: some View {
		Form {
			Section("Case1") {
				CustomView()
			}
			Section("Case2") {
				CustomView()
					.font(.custom("Arial", size: 28, relativeTo: .caption))
			}
			Section("Case3") {
				VStack {
					CustomView()
				}
				.font(.custom("Helvetica", size: 24, relativeTo: .body).bold())
			}
		}
	}
}

fileprivate struct CustomView: View {
	@Environment(\.font) var font
	private var defaultFont: Font = .footnote

	var body: some View {
		VStack(alignment: .leading) {
			Text("Default Content")
			Text("Sensitive Content")
				.font(font ?? defaultFont)
		}
	}
}

fileprivate extension CustomView {
	func font(_ font: Font) -> some View {
		var updatedView = self
		updatedView.defaultFont = font     // update in copy
		return updatedView
	}
}



struct TestOverrideFontCustomView_Previews: PreviewProvider {
	static var previews: some View {
		TestOverrideFontCustomView()
	}
}
