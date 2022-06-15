```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI Picker item .foregroundColor() not working (by Joe Scotto)

A: Well... nothing direct, but you can play with the following approach... which allows to get some interesting effects (maybe someone could be appropriate)

Demo prepared & tested with Xcode 12 / iOS 14

![QLmQV](https://user-images.githubusercontent.com/62171579/173890610-4c5a29d6-b3e8-45ae-880f-cde944273605.png)

		Picker("Theme Color", selection: $themeColor) {
			 ForEach(0..<4) { _ in
				  Text("Color")
			 }
		}.pickerStyle(SegmentedPickerStyle())
		.colorMultiply(.white).colorInvert()


and even

![EHq0N](https://user-images.githubusercontent.com/62171579/173890653-ddbbecac-bcd3-4adb-bcc3-42df2b160629.png)

		Picker("Theme Color", selection: $themeColor) {
			 ForEach(0..<4) { _ in
				  Text("Color")
			 }
		}.pickerStyle(SegmentedPickerStyle())
		.colorMultiply(.white).colorInvert()
		.colorMultiply(.orange).colorInvert()

