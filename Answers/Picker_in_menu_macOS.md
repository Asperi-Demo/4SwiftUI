```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to prevent Picker to fold into a submenu in SwiftUI macOS (by Roman Banks)

A: You need `inline` picker style, like

	 Picker("Budgets", selection: $account) {
		  Button("Personal") {}.tag(1)
		  Button("Business") {}.tag(2)
	 }
	 .labelsHidden()
	 .pickerStyle(.inline)    // << here !!

![mwAAI](https://user-images.githubusercontent.com/62171579/176986787-81330dcb-a8ee-4042-a77f-6b53ffd5ec8d.png)
