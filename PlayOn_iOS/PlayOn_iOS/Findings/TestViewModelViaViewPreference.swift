// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI

struct TestViewModelViaViewPreference: View {
	@State private var childValue: String?
	var body: some View {
		VStack {
			ChildView()
			Text("Received: \(childValue ?? "none")")
		}
		.onPreferenceChange(NewValueKey.self) {
			childValue = $0
		}
	}

	struct ChildView: View {
		@StateObject var vm = SomeViewModel()

		var body: some View {
			// Self._printChanges() << call to debug reason of refresh
			Button("Generate") {
				vm.value = String(Int.random(in: 0...9))
			}
			.preference(key: NewValueKey.self, value: vm.value)
		}
	}

	fileprivate struct NewValueKey: PreferenceKey {
		static var defaultValue: String? = nil
		static func reduce(value: inout String?, nextValue: () -> String?) {  // << fix !!
			value = nextValue()
		}
	}

	public class SomeViewModel: ObservableObject {
		@Published public var value: String?
	}
}

struct TestViewModelViaViewPreference_Previews: PreviewProvider {
	static var previews: some View {
		TestViewModelViaViewPreference()
	}
}
