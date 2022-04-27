```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Align Items in swiftUI Stack Evenly (by lenny)

A: Assuming imems of the same type view here is a possible approach - prepare a container
wrapper for an array of those item views, so it justifies . 

Prepared & tested with Xcode 12 / iOS 14.

![M0g0T](https://user-images.githubusercontent.com/62171579/165547087-766f909c-7eec-4603-8a51-535647db2289.png)

```
struct ItemView: View {
	let value: Int
	var body: some View {
		Text("Item\(value)")
			.padding()
			.background(Color.blue)
	}
}

struct JustifiedContainer<V: View>: View {
	let views: [V]
	
	init(_ views: V...) {
		self.views = views
	}

	init(_ views: [V]) {
		self.views = views
	}
	
	var body: some View {
		HStack {
			ForEach(views.indices, id: \.self) { i in
				views[i]
				if views.count > 1 && i < views.count - 1 {
					Spacer()
				}
			}
		}
	}
}

struct Demo_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			JustifiedContainer(
					ItemView(value: 1),
					ItemView(value: 2),
					ItemView(value: 3)
			)
			JustifiedContainer([
					ItemView(value: 1),
					ItemView(value: 2),
					ItemView(value: 3),
					ItemView(value: 4)
			])
		}
    }
}
```
