```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to save a UUID in SwiftUI using @AppStorage (by Gerry Shaw)

A: We can confirm `UUID` to `RawRepresentable` protocol so it fits to one of `AppStorage` init.

Here is a possible approach. Tested with Xcode 13.2 / iOS 15.2

```
extension UUID: RawRepresentable {
	public var rawValue: String {
		self.uuidString
	}

	public typealias RawValue = String

	public init?(rawValue: RawValue) {
		self.init(uuidString: rawValue)
	}
}
```

and then your original (below) code just works 'as-is'

```
@AppStorage("navigationWaypointID") var navigationWaypointID: UUID?
```
