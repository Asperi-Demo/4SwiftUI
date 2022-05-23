```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Sending preference key when publisher/binding emits value (by drekka)

A: A ViewPreferences is a mechanism to trasfer values via view hierarchy **upwards**, so
having changed preference value in some child view we transfer it to parent view. The `.preference(key`
modifier generates new view, so it is activated/rebuilt once any dependent value is updated, so
we can inject view model value directly into preference modifier.

Here is a demo of approach. Tested with XCode 13.3 / iOS 15.4

```
struct TestViewModelViaViewPreference: View {
	@State private var childValue: String?
	var body: some View {
		VStack {
			ChildView()
			Text("Received: \(childValue ?? "none")")
		}
		.onPreferenceChange(NewValueKey.self) {  // listen for child value
			childValue = $0
		}
	}

	struct ChildView: View {
		@StateObject var vm = SomeViewModel()

		var body: some View {
			Button("Generate") {
				vm.value = String(Int.random(in: 0...9))
			}
			.preference(key: NewValueKey.self, value: vm.value)   // << direct inject !!
		}
	}

	struct NewValueKey: PreferenceKey {
		static var defaultValue: String? = nil
		static func reduce(value: inout String?, nextValue: () -> String?) {  // << fix !!
			value = nextValue()
		}
	}

	public class SomeViewModel: ObservableObject {
		@Published public var value: String?
	}
}
```

[Test module in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestViewModelViaViewPreference.swift)
