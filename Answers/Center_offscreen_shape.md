```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Center an off screen SwiftUI view (by ammerzon)

A: Here is possible approach to solve such kind to task. 

Prepared with Xcode 12.4/iOS 14.4

![gBh2Q](https://user-images.githubusercontent.com/62171579/170645039-37cc4e11-db7a-44af-b383-355a14a4b630.png)

	var body: some View {
		ZStack {
			VStack {
				Color.yellow
					.clipShape(Circle())
				Color.clear
			}
			.scaleEffect(1.8)   // << tune factor as needed !!
			Text("Demo")
		}.edgesIgnoringSafeArea(.all)
	}

