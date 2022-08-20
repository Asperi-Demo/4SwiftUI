// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

// Variant 2
struct TestEnvironmentDepenencyInjectionIinternalView2: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    struct MainView: View {
        @StateObject var settings: Settings

        init(isVisible: Bool) {
        	// initialized only once(!), so concequent changes via init will be ignored
        	_settings = StateObject(wrappedValue: Settings(isVisible: isVisible))
		}

        var body: some View {
            VStack {
                Button("Toggle Visibility") {
                    settings.isVisible.toggle()
                }
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .opacity(settings.isVisible ? 1 : 0)
            }
            .animation(.linear(duration: 2.0), value: settings.isVisible)
        }
    }

    var body: some View {
        MainView(isVisible: horizontalSizeClass == .regular) // << inject initial state
    }

	class Settings: ObservableObject {
		@Published var isVisible: Bool

		init(isVisible: Bool) {
			self.isVisible = isVisible
		}
	}
}

// Variant 1
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
        TestEnvironmentDepenencyInjectionIinternalView2()
        TestEnvironmentDepenencyInjectionIinternalView()
    }
}
