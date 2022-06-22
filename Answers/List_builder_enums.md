```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Multiple enum types list all cases (by Lukas)

A: Here is a demo of possible solution. Prepared with Xcode 12.1 / iOS 14.1

![iW1An](https://user-images.githubusercontent.com/62171579/174964754-534d3074-3152-4db2-9bea-6d1aa635e571.png)


```
enum Fish: String, CaseIterable {
    case goldfish
    case blueTang = "blue_tang"
    case shark
}

func view<T: CaseIterable & Hashable>(for type: T.Type) -> some View where T.AllCases: RandomAccessCollection {
	VStack(alignment: .leading) {
		Text(String(describing: type)).bold()
		ForEach(type.allCases, id: \.self) { item in
			Text(String(describing: item))
		}
	}
}

struct FishDemoView: View {
	var body: some View {
		view(for: Fish.self)
	}
}
```
