// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI


extension View {
	func position(_ point: CGPoint, at anchor: Alignment = .center) -> some View {
		Color.clear.frame(width: 1, height: 1) 	// << achor !!
			.overlay(self, alignment: anchor)	// << alignment to anchor !!
			.position(point)
	}
}

struct TestPositionAtAnchor: View {
	@State private var anchor: Alignment = .center
    var body: some View {
    	GeometryReader { gp in
			Rectangle().stroke(.red)
				.frame(width: 200, height: 200)
				.position(gp.frame(in: .local).center)

			Rectangle().fill(.blue)
				.frame(width: 100, height: 100)
				.position(gp.frame(in: .local).center, at: anchor)  // << here !!

			VStack(alignment: .leading) {
				Button("Default") { anchor = .center }
				Button("Leading") { anchor = .leading }
				Button("Trailing") { anchor = .trailing }
				Button("Top Leading") { anchor = .topLeading }
				Button("Bottom") { anchor = .bottom }
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
		}
		.animation(.default, value: anchor)
    }
}

struct TestPositionAtAnchor_Previews: PreviewProvider {
    static var previews: some View {
        TestPositionAtAnchor()
    }
}
