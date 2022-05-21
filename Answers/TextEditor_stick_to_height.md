```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: TextEditor sticking to minHeight inSwiftUI (by ASSeeger)

A: Here is possible solution. Tested with Xcode 12 / iOS 14.

![Z53OU](https://user-images.githubusercontent.com/62171579/169653916-3277b5ed-95be-4d06-89b6-cc7475947e45.png)

    ScrollView {
        // make clear static text in background to define size and
        // have TextEditor in front with same text fit
		Text(loremIpsum).foregroundColor(.clear).padding(8)
	    .frame(maxWidth: .infinity)
		.overlay(
			TextEditor(text: .constant(loremIpsum))
		)
    }
    .frame(minHeight: 200.0)
    .border(Color.yellow, width: 3.0)
