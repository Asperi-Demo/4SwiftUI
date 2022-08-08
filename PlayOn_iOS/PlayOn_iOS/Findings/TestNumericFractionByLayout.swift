// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestNumericFractionByLayout: View {
	var body: some View {
		VStack(spacing: 8) {
			FractionView(numerator: "1", denominator: "2")
			FractionView(numerator: "5", denominator: "7")
			FractionView(numerator: "11", denominator: "19")
			FractionView(numerator: "31", denominator: "932")
		}
	}
	
	struct FractionView: View {
		@ScaledMetric var scale: CGFloat = 24
		
		var numerator: String
		var denominator: String
		var body: some View {
			ZStack {
				Text("\(numerator) ")
					.alignmentGuide(VerticalAlignment.center,
									computeValue: { d in d[.bottom] })
					.alignmentGuide(HorizontalAlignment.center,
									computeValue: { d in d[.trailing] })
				
				Text("\u{2215}").font(.system(size: scale))
				
				Text(" \(denominator)")
					.alignmentGuide(VerticalAlignment.center,
									computeValue: { d in d[.top] })
					.alignmentGuide(HorizontalAlignment.center,
									computeValue: { d in d[.leading] })
			}
		}
	}
}

struct TestNumericFractionByLayout_Previews: PreviewProvider {
	static var previews: some View {
		TestNumericFractionByLayout()
	}
}
