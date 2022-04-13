```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Initialize @StateObject with a parameter in SwiftUI (by )

A: The `StateObject` has similar behavior as a `State`, ie initialized once per view, so here is 
a demo of solution (confirmed by Apple at WWDC21!).

**NOTE: You might meet a reference on documentation that it should be avoid - that doc is wrong**

Tested with Xcode 12b.

```
class MyObject: ObservableObject {
    @Published var id: Int
    init(id: Int) {
        self.id = id
    }
}

struct MyView: View {
    @StateObject private var object: MyObject
    init(id: Int = 1) {
        _object = StateObject(wrappedValue: MyObject(id: id))
    }

    var body: some View {
        Text("Test: \(object.id)")
    }
}
```

> This came up during the SwiftUI digital lounge of WWDC21 and was endorsed by 
> the SwiftUI team in that context. SwiftUI-Lab.com's amazing summary of the 
> digital lounge recorded this here: [swiftui-lab.com/random-lessons#data-10](swiftui-lab.com/random-lessons#data-10) Of 
> course it depends on you and your project whether this kind of soft endorsement 
> makes you sufficiently comfortable in following this approach. – Alex Fringes
