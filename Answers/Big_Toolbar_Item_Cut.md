```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

A: The bug is actually that it is not refreshed to clipped area from start, because it is actually clipped by 
UINavigationBar, but probably due to rendering optimization initial drawing cached and flashed to screen. 
If we try to enter View Debug (below) in Xcode, we see that it is within UINavigationBar height, no more:

![qO9YJ](https://user-images.githubusercontent.com/62171579/167240354-32e7c4b0-4313-4580-8314-b765cf296ea3.png)

A possible solution is to use that widget (Circle in the case) *above* `NavigationView` and align it with toolbar item.

![pLbZ5](https://user-images.githubusercontent.com/62171579/167240349-80bd3f22-439f-4bfe-84f5-45efc640a4f7.gif)

Here is main part:

	.toolbar {
		Color.clear            // reserve space !!
			.frame(width: 150)
			.overlay(GeometryReader {
				Color.clear.preference(key: ViewPointKey.self,
            value: [$0.frame(in: .global).center])  // get global position !!
			})
	}

    //...

	Circle().fill(Color.red)
		.frame(width: 150, height: 150)
		.position(x: pos.x, y: pos.y)     // align to toolbar item !!

    //...

	.onPreferenceChange(ViewPointKey.self) {
		pos = $0.first ?? .zero           // store to align Circle !!
	}

[Test module in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestBigToolbarItemCut.swift)
