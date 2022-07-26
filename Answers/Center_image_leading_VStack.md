```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Center Image in VStack leading alignment (by cole)

A: Here is a solution - use separated alignments for `VStack` and for image. Tested with Xcode 12.1 / iOS 14.1

![AUr4J](https://user-images.githubusercontent.com/62171579/167235580-67ae06e2-89e1-4828-ac39-90535909a1d1.png)

	ScrollView {
		VStack (alignment: .leading, spacing: 10) {    // << here !!
			Text("Title ")
			Image(systemName:"star.fill")
				.resizable()
				.frame(width: 20, height: 20)
				.frame(maxWidth: .infinity, alignment: .center)    // << here !!
			Divider()
		}
	}
