// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestAnchorPrefInDictionary: View {
	enum MyPreferenceKeyType: Hashable {
		case firstBounds
		case secondBounds
	}

	struct MyPreferenceKey: PreferenceKey {
		typealias Value = [MyPreferenceKeyType: Anchor<CGRect>]
		static var defaultValue: Value { [:] }

		static func reduce(value: inout Value, nextValue: () -> Value) {
			value.merge(nextValue()) { $1 }
		}
	}

	var body: some View {
		HStack {
			Text("Hello")
				.anchorPreference(key: MyPreferenceKey.self, value: .bounds) {
					[.firstBounds: $0]
				}
			Text("World")
				.anchorPreference(key: MyPreferenceKey.self, value: .bounds) {
					[.secondBounds: $0]
				}
		}
		.overlayPreferenceValue(MyPreferenceKey.self) { prefs in
			if let first = prefs[.firstBounds] {
				GeometryReader { gp in
					Rectangle()
						.stroke(Color.red, lineWidth: 5)
						.frame(width: gp[first].width, height: gp[first].height)
						.position(x: gp[first].midX, y: gp[first].midY)
				}
			}
			if let second = prefs[.secondBounds] {
				GeometryReader { gp in
					Rectangle()
						.stroke(Color.orange, lineWidth: 5)
						.frame(width: gp[second].width, height: gp[second].height)
						.position(x: gp[second].midX, y: gp[second].midY)
				}
			}
		}
	}
}

struct TestAnchorPrefInDictionary_Previews: PreviewProvider {
	static var previews: some View {
		TestAnchorPrefInDictionary()
	}
}
