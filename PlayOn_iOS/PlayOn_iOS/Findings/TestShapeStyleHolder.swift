// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestShapeStyleHolder: View {

	struct RectangleStyle<S: ShapeStyle> {
		private let style: S
		init(_ style: S) {
			self.style = style
		}

		func getStyle() -> some ShapeStyle {
			self.style
		}
	}


	let myStyle = RectangleStyle(LinearGradient(
		gradient: Gradient(colors: [.red, .blue]),
		startPoint: .top,
		endPoint: .bottom
	))
	
	var body: some View {
		Rectangle()
			.fill(myStyle.getStyle())
			.frame(width: 200, height: 200)
	}
}

struct TestShapeStyleHolder_Previews: PreviewProvider {
	static var previews: some View {
		TestShapeStyleHolder()
	}
}
