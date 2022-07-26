// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCombiningEnvValues: View {
	  @Environment(\.horizontalSizeClass) var horizontalSizeClass
	  @Environment(\.sizeCategory) var sizeCategory

    var body: some View {
    	VStack {
	        TestView()
        }
        // combining updates of several environments into custom one for
        // children views
		.environment(\.isHorCompactLayout, horizontalSizeClass == .compact || sizeCategory.isAccessibilityCategory)
    }

	struct TestView: View {
		@Environment(\.isHorCompactLayout) var horLayout

		var body: some View {
			Text(horLayout ? "HorCompact" : "Other")
		}
	}

}

struct HorCompactLayoutKey: EnvironmentKey {
	static let defaultValue: Bool = false
}

extension EnvironmentValues {
	var isHorCompactLayout: Bool {
		get { self[HorCompactLayoutKey.self] }
		set { self[HorCompactLayoutKey.self] = newValue }
	}
}

struct TestCombiningEnvValues_Previews: PreviewProvider {
    static var previews: some View {
        TestCombiningEnvValues()
    }
}
