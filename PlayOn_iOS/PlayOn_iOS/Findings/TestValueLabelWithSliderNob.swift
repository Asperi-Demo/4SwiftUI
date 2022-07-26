// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestValueLabelWithSliderNob: View {
	var body: some View {
		SliderView()
	}

	struct SliderView: View {
		@State private var speed = 37.0

		var minValue: Double = 1
		var maxValue: Double = 100

		var body: some View {
			HStack {
				Text("\(minValue,specifier: "%.f")")
				Slider(value: $speed, in: minValue...maxValue, step: 1)
					.alignmentGuide(VerticalAlignment.center) { $0[VerticalAlignment.center]}
					.padding(.top)
					.overlay(GeometryReader { gp in
						Text("\(speed,specifier: "%.f")").foregroundColor(.blue)
							.alignmentGuide(HorizontalAlignment.leading) {
								$0[HorizontalAlignment.leading] - (gp.size.width - $0.width) * speed / ( maxValue - minValue)
							}
							.frame(maxWidth: .infinity, alignment: .leading)
					}, alignment: .top)
				Text("\(maxValue,specifier: "%.f")")
			}
			.padding()
		}
	}

}

struct TestValueLabelWithSliderNob_Previews: PreviewProvider {
	static var previews: some View {
		TestValueLabelWithSliderNob()
	}
}
