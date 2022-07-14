```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Swiftui How to pass a view that takes a parameter to another view that will set the parameter when calling the view (by Richard Legault)

A: We can pass parameter as view builder argument.

Here is possible approach (tested with Xcode 12.1 / iOS 14.1)

```
struct ContentView2<LinkView: View>: View {
	let linkView: (String)->LinkView
	let testList = ["Test1", "Test2", "Test3"]
	var body: some View {
		HStack {
			NavigationView {
				List {
					ForEach(testList, id: \.self) { test in
						NavigationLink(destination: self.linkView(test)) {Text(test)}
					}
				}
			}
		}
	}
	
	init(@ViewBuilder linkView: @escaping (String)->LinkView) {
		self.linkView = linkView
	}
}

struct ContentView1: View {
    var body: some View {
        ContentView2() { value in
            DestinationLinkView(title: value)
        }
   }
}
```
