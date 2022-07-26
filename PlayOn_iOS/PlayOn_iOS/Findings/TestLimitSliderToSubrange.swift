// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestLimitSliderToSubrange: View {
	@State private var value: Double = 11
	@State private var allowed: ClosedRange<Double> = 10...20

	var proxy: Binding<Double> {
		Binding(
			get: { value },
			set: {
				value = allowed.contains($0) ? $0 : value
			}
		)
	}
	var body: some View {
		VStack {
			Text("Value: \(Int(value))")
			Slider(value: proxy, in: 0...50, step: 1)
		}
	}
}

struct TestLimitSliderToSubrange_Previews: PreviewProvider {
    static var previews: some View {
        TestLimitSliderToSubrange()
    }
}
