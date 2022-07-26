```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Swift ui macOS event detect change accent color (by Paul)

A: A possible approach is to use changes in `NSUserDefaults` via `AppStorage` observer, like

```
struct ContentView: View {
	@AppStorage("AppleAccentColor") var appleAccentColor: Int = 0

	var body: some View {
		Text("Hello world!")
			.foregroundColor(.accentColor)   // << updated automatically
			.onChange(of: appleAccentColor) { _ in
				print("Side-effect is here")
                // also can be read via NSColor.controlAccentColor
			}
	}
}
```

Tested with Xcode 15 / macOS 11.5
