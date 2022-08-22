>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI change vertical alignment of Label to center image and text (by Godfather)

A: We can do this using custom label style, like 

```
struct CenterIconStyle: LabelStyle {
	func makeBody(configuration: Configuration) -> some View {
		HStack(alignment: .center) {    // << here !!
			configuration.icon
			configuration.title
		}
	}
}
```

and use it

	Label {
		Text("Test fdasf \n adfsa dsfsd f asdf \n asd fasd fads sad fda")
	} icon: {
		Image(systemName: true ? "checkmark.circle.fill" : "circle")
	}
	.labelStyle(CenterIconStyle())    // << here !!

![mjcJR](https://user-images.githubusercontent.com/62171579/185857749-1eec112f-b426-4f57-8e2e-9182b4db5147.png)

Tested with Xcode 13 / iOS 15
