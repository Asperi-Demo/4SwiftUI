// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI
import CoreText

struct TestRoundTripText: View {
	let text = "Infinitely running around text"

	init() {
		let font = UIFont.preferredFont(forTextStyle: .body)
		textWidth = (text as NSString).size(withAttributes: [.font : font]).width
	}

	@State private var go = false

	private let textWidth: CGFloat
	private let animation = Animation.linear(duration: 5).repeatForever(autoreverses: false)
	private let transition = AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))

	// The main task here is to give a frame for text as 'screen width + own width'
	var body: some View {
		GeometryReader { gp in
			VStack {
				Text(text)
					.fixedSize()
					.frame(width: gp.size.width + textWidth, alignment: .trailing)
					.id(go)
					.transition(transition)
					.onAppear{ go.toggle() }
					.animation(animation, value: go)
			}
		}.fixedSize(horizontal: false, vertical: true)
	}
}

struct TestRoundTripText_Previews: PreviewProvider {
	static var previews: some View {
		TestRoundTripText()
	}
}
