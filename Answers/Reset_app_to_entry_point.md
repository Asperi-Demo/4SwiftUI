```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - Using @main to set the rootViewController (by squarehippo10)

A: Here is possible alternate approach that do actually the same as your old `toContentView`

1) helper class

```
class Resetter: ObservableObject {
	static let shared = Resetter()

	@Published private(set) var contentID = UUID()

	func toContentView() {
		contentID = UUID()
	}
}
```

2) content of @main 

```
	@StateObject var resetter = Resetter.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
			   .id(resetter.contentID)
        }
    }
```

3) now from anywhere in code to reset to `ContentView` you can just call

```
Resetter.shared.toContentView()
```
