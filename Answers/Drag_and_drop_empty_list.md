```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Crash when drag into an empty list (by John Henryk)

A: Here is possible approach to handle this scenario, which is safe and continue to work under even if/after Apple fixed the crash.

Tested with Xcode 12 / iOS 14 (List border added for demo)

![EMaQU](https://user-images.githubusercontent.com/62171579/178094881-058d206e-380d-4e12-9ad7-d40206ce028e.gif)

```
import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
	let string = "Hello World"
	@State private var items: [String] = []

    // border with highlight added just for better visibility
	@State private var dragOver = false
	
	var body: some View {
		HStack {
			Text(string) // Object to drag
				.onDrag({NSItemProvider(object: string as NSString)})
			
			List {
				ForEach(items, id: \.self) {
					Text($0)
				}
				.onInsert(of: [.text]) { index, providers in
					self.handle(providers: providers, index: index)
				}
			}
			.overlay(helperOverlay()) // << helper to handle empty list
			.border(dragOver ? Color.red : Color.green, width: 4) // << just for demo
		}
	}
	
	private func helperOverlay() -> some View {
		Group {
			if items.isEmpty {
				Color.white.opacity(0.0001)  // << should be something opaque
					.onDrop(of: [.text], isTargeted: $dragOver) { providers -> Bool in
						self.handle(providers: providers)
						return true
					}
			}
		}
	}
	
	private func handle(providers: [NSItemProvider], index: Int? = nil) {
		guard let provider = providers.first else { return }
		provider.loadDataRepresentation(forTypeIdentifier: "public.text") { (data, _) in
			guard let data = data, let value = String(data: data, encoding: .utf8) else { return }
			if let index = index {
				items.insert(value, at: index)
			} else {
				items.append(value)
			}
		}
	}
}
```
