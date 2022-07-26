```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: macOS SwiftUI Table with contextMenu (by Marcos Tanaka)

A: You can make cell view with the following extensions and use it for each column cell, then it will be clickable in any row place

	Text("Item at \($0.name!)")
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) // << this !!
		.contentShape(Rectangle())                                            // << this !!
		.contextMenu {
			Button(action: {}) { Text("Action 1") }
			Divider()
			Button(action: {}) { Text("Action 2") }
			Button(action: {}) { Text("Action 3") }
		}

