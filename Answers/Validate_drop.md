```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: is anyone able to restrict the type of the objects dropped on the mac in SwiftUI 3? (by godbout)

A: We need to validate manually, using `DropDelegate` of what kind of file is dragged over.

Here is a simplified demo of possible approach. Tested with Xcode 13 / macOS 11.6


```
let delegate = MyDelegate()

...


List(appsToIgnore, id: \.self, selection: $selection) {
    Text($0)
}
.onDrop(of: [.fileURL], delegate: delegate) // << accept file URLs
```

and verification part like

```
class MyDelegate: DropDelegate {

	func validateDrop(info: DropInfo) -> Bool {
        // find provider with file URL
		guard info.hasItemsConforming(to: [.fileURL]) else { return false }
		guard let provider = info.itemProviders(for: [.fileURL]).first else { return false }

		var result = false
		if provider.canLoadObject(ofClass: String.self) {
			let group = DispatchGroup()
			group.enter()     // << make decoding sync

            // decode URL from item provider
			_ = provider.loadObject(ofClass: String.self) { value, _ in
				defer { group.leave() }
				guard let fileURL = value, let url = URL(string: fileURL) else { return }

                // verify type of content by URL
				let flag = try? url.resourceValues(forKeys: [.contentTypeKey]).contentType == .applicationBundle
				result = flag ?? false
			}

            // wait a bit for verification result
			_ = group.wait(timeout: .now() + 0.5)
		}
		return result
	}

	func performDrop(info: DropInfo) -> Bool {
        // handling code is here
		return true
	}
}
```
