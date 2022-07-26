// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestTextFieldWithBoxedLabel: View {
	@State private var value = ""

	var body: some View {
		let x1 = CGFloat(20); let x2 = CGFloat(8)
		TextField("Placeholder text", text: $value)
			.padding(x1)
			.background(RoundedRectangle(cornerRadius: x2).stroke(.blue, lineWidth: 2).padding(.top, x2 / 2))
			.overlay(
				Text("Label").bold()
					.foregroundColor(.blue)
					.alignmentGuide(VerticalAlignment.top) { $0[VerticalAlignment.center] }
					.padding(.horizontal, x2)
					.background(.white)
					.padding(.leading, x1-x2)
			, alignment: .topLeading)
			.font(.title2)
	}
}

struct TestTextFieldWithBoxedLabel_Previews: PreviewProvider {
    static var previews: some View {
        TestTextFieldWithBoxedLabel()
        	.padding()
    }
}
