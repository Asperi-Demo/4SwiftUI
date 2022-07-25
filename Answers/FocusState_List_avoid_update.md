```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI List with @FocusState and focus change handling (by Sergey)

A: I recommend to consider separation of list row content into standalone view and use something like focus "selection" approach. Having `FocusState` internal of each row prevents parent view from unneeded updates (something like pre-"set up" I assume).

Tested with Xcode 13.4 / iOS 15.5

```
struct ContentView: View {

	enum Field: Hashable {
		case fieldId(Int)
	}

	@State private var inFocus: Field?

	var body: some View {
		List {
			let _ = Self._printChanges()
			ForEach(0..<100, id: \.self) {
				ExtractedView(i: $0, inFocus: $inFocus)
			}
		}
		.onChange(of: inFocus) { _ in
			print("Not printed unless focused manually")
		}
	}

	struct ExtractedView: View {
		let i: Int
		@Binding var inFocus: Field?

		@State private var text: String = ""
		@FocusState private var focus: Bool     // << internal !!

		var body: some View {
			TextField("Enter the text for \(i)", text: $text)
				.focused($focus)
				.id(Field.fieldId(i))
				.onChange(of: focus) { _ in
					inFocus = .fieldId(i)     // << report selection outside
				}
		}
	}
}
```
