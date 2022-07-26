```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI Form NavigationButton Style (by Chris)

A: I think you just need to add that link as footer of previous Section (that one containing *Forgot Password?*), like

![s7ZQq](https://user-images.githubusercontent.com/62171579/176404864-9366ee5d-62f4-4811-99ea-e93a1608833b.png)

    Section(footer:
		HStack {
			Spacer()
			NavigationLink(
				destination: SignUpView(),
				label: {
					 Text("Don't have an account?")
						  .foregroundColor(.gray)
			})
		}) {

Tested and worked with Xcode 12.4 / iOS 14.4
