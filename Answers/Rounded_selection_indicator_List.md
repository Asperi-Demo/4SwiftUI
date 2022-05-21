```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI List . How to make a round rectangle as an indicator for a selected row on a list (by Duck)

![uHwDO](https://user-images.githubusercontent.com/62171579/169648030-a985c1b5-1b4d-46ea-b4ce-425675637289.png)

A: Here is a demo of possible solution. Tested with Xcode 12 / iOS 14.

	.listRowBackground(Group {
		if selectedItem == item {
			Color.yellow.mask(RoundedRectangle(cornerRadius: 24))
		} else { Color.clear }
	})

