// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestGeometryEffectOnPickerSelection: View {
	struct MyShake: GeometryEffect {
		var animatableData: CGFloat

		func modifier(_ x: CGFloat) -> CGFloat {
			10 * sin(x * .pi * 2)
		}

		func effectValue(size: CGSize) -> ProjectionTransform {
			let transform1 = ProjectionTransform(CGAffineTransform(translationX: 10 + modifier(animatableData), y: 0))
			return transform1
		}
	}

	let names = ["John", "Betty", "Fred", "May", "Judy"]

	@State var selection = 0
	@State var shaking = false

	var body: some View {
		VStack(spacing: 20) {
			Picker("Name", selection: $selection) {
				ForEach(names.indices, id: \.self) { i in
					Text(names[i]).tag(i)
				}
			}.pickerStyle(SegmentedPickerStyle())

			Text(names[self.selection])
				.font(.title)
				.fixedSize()
				.modifier(MyShake(animatableData: CGFloat(self.shaking ? 1 : 0)))
				.onChange(of: selection) { _ in shaking.toggle() }
				.animation(Animation.linear(duration: 0.3), value: shaking)
		}
		.padding()
	}
}

struct TestGeometryEffectOnPickerSelection_Previews: PreviewProvider {
	static var previews: some View {
		TestGeometryEffectOnPickerSelection()
	}
}
