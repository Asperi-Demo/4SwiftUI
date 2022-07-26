```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI switch between NavigationViewStyles (by koleS)

A: We cannot use ternary operator in `navigationViewStyle` modifier, because styles have different types, but you can use custom modifier like the following

```
extension NavigationView {
	@ViewBuilder
	func switchStyle(if flag: Bool) -> some View {
		if flag {
			self.navigationViewStyle(DefaultNavigationViewStyle())
		} else {
			self.navigationViewStyle(StackNavigationViewStyle())
		}
	}
}
```
