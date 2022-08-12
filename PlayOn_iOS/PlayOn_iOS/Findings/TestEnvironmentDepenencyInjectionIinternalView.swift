// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestEnvironmentDepenencyInjectionIinternalView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

	struct MainView: View {
		// later knonw injection
		@EnvironmentObject var settings: Settings

		var body: some View {
			VStack {
				Button("Toggle Visibility") {
					settings.isVisible.toggle()
				}
				Rectangle()
					.frame(width: 100, height: 100)
					.foregroundColor(.blue)
					.opacity(settings.isVisible ? 1 : 0) // << direct dependency !!
			}
			.animation(.linear(duration: 2.0), value: settings.isVisible) // << explicit animation
		}
	}

    var body: some View {
    	MainView()          // << internal view
    		.environmentObject(
    			Settings(isVisible: horizontalSizeClass == .regular) // << initial injecttion !!
			)
    }

	class Settings: ObservableObject {
		@Published var isVisible: Bool
		init(isVisible: Bool = true) {
			self.isVisible = isVisible
		}
	}
}

struct Environment_Depenency_injection_internal_view_Previews: PreviewProvider {
    static var previews: some View {
        TestEnvironmentDepenencyInjectionIinternalView()
    }
}
