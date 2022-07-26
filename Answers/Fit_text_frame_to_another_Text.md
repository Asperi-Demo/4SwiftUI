```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Scaling down a text's font size to fit its length to another text in SwiftUI (by Kay)

A: Here is possible simple approach (tested with Xcode 13.4 / iOS 15.5)

**Update:** found even more simpler, based on the same concept (works with dynamic sizes as well)

```
Text("A reference text")
	.padding(.bottom)     // << spacing can be tuned 
    .overlay(
    	Text("(Adjust the length of this line to match the one above)")
			.scaledToFit()
			.minimumScaleFactor(0.01)
    , alignment: .bottom)     // << important !!
```
**Original:**

	VStack {
		let ref = "A reference text"
		let target = "(Adjust the length of this line to match the one above)"
		Text(ref)
		Text(ref).opacity(0)
			.overlay(Text(target)
				.scaledToFit()
				.minimumScaleFactor(0.01)
			)
	}

![zxlrJ](https://user-images.githubusercontent.com/62171579/176988236-3a79243d-118f-4c75-95e2-bedf3199f98e.png)
