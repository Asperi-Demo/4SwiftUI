// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestRoundingBorderAndGap: View {

	var size: CGFloat = 200     // << any !!
	var radius: CGFloat = 24     // << any !!
	var border: CGFloat = 18     // << any !!
	var gap: CGFloat = 2     // << any !!

	var body: some View {
		Image("picture").resizable()
			.frame(width:size * 1.5, height: size)     // << any !!
		        // below is calculable alignment for corners
			.clipShape(
				RoundedRectangle(cornerRadius: radius + border/2 - gap)
			)
			.padding(border/2 + gap)
			.overlay(
				RoundedRectangle(cornerRadius: radius + border)
					.stroke(.yellow, lineWidth: border)
			)
	}
}

struct TestRoundingBorderAndGap_Previews: PreviewProvider {
    static var previews: some View {
        TestRoundingBorderAndGap()
    }
}
