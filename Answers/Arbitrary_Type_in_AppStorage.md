```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
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
