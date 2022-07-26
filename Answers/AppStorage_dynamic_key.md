```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How can I store a variable as the key of an @AppStorage variable (by peterk)

A: You can separate `id` dependent subview and initialize `AppStorage` property wrapper dynamically.

Here is a solution. Tested with Xcode 12.1 / iOS 14.1

```
struct IsSignedView: View {

	@AppStorage var isSigned: Bool     // << declare

	init(id: String) {
        // Initialize with default value and dynamic key from argument
		self._isSigned = AppStorage(wrappedValue: false, id)
	}

    // ... other dependent code here
}
```
