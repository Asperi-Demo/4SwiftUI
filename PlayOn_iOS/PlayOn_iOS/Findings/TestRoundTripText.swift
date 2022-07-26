// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI
import CoreText

// Global flag to activate alternate solutions
fileprivate let PRECALCULATED_WIDTH = true

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
	private let alignment = Alignment(horizontal: .myLeading, vertical: .center)

	@State private var reset = false

	// A challenge here is to move text out of screen so firts animation started from
	// outside (instead of appeared right on screen and run)

	var body: some View {
    	Text(" ")
    		.frame(maxWidth: .infinity).overlay(runnerView, alignment: .trailing)
			.id(reset)       // << should be separated otherwise running animation breaks
			.onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
				reset.toggle()
			}
	}

	@ViewBuilder var runnerView: some View {
// MARK: >> start of alternates
		if PRECALCULATED_WIDTH {
			// Simple/faster(?) variant when width of text is pre-calculated based on some known
			// font, which is not going to be changed externally.
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

		} else {
			// More dynamic and complex variant, does not depend on font or text size;
			// uses run-time layout engine to move text out of screen
			//
			// !!!IMPORTANT: This block must be directly copied inside
			// overlay instead of `runnerView`, otherwise introduced new
			// view (by ViewBuilder or Group) breaks overylay layout!!!
			ZStack(alignment: alignment) {
				Text(text).fixedSize().opacity(0)
					.alignmentGuide(.myLeading) { $0[HorizontalAlignment.trailing] }
				GeometryReader { gp in
					HStack(spacing: 0) {
						Text(text).fixedSize()
						Color.clear.frame(height: 4)
					}
					.animation(nil, value: go)
					.id(go)
					.transition(transition)
					.onAppear{ go.toggle() }
					.animation(animation, value: go)
				}
			}
			.frame(alignment: alignment)
		}
// MARK: << end of alternates
	}
}

struct TestRoundTripText_Previews: PreviewProvider {
	static var previews: some View {
		TestRoundTripText()
	}
}

extension HorizontalAlignment {
   private enum MyLeadingAlignment: AlignmentID {
      static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
         return dimensions[HorizontalAlignment.leading]
      }
   }
   static let myLeading = HorizontalAlignment(MyLeadingAlignment.self)
}
