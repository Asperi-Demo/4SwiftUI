// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomShapeStyle: View {
	var body: some View {
		ContentView()
	}

	struct ContentView: View {
		var body: some View {
			Circle()
				.fill(RedView())
				.aspectRatio(contentMode: .fit)
				.border(.green)
		}
	}

	struct RedView: ShapeStyle {
		public static func _makeView<S>(view: SwiftUI._GraphValue<SwiftUI._ShapeView<S, SwiftUI.Color>>, inputs: SwiftUI._ViewInputs) -> SwiftUI._ViewOutputs where S : SwiftUI.Shape {
			Color._makeView(view: view, inputs: inputs)
		}

		public func _apply(to shape: inout SwiftUI._ShapeStyle_Shape) {
			Color.red._apply(to: &shape)
		}

		public static func _apply(to type: inout SwiftUI._ShapeStyle_ShapeType) {
			Color._apply(to: &type)
		}
	}
}

struct TestCustomShapeStyle_Previews: PreviewProvider {
	static var previews: some View {
		TestCustomShapeStyle()
	}
}
