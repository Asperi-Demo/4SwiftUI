```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI View not updating based on @ObservedObject (by Anton)

    @ObservedObject var numberLine = NumberLine()

    var body: some View {
        VStack {
            HStack {
                ForEach(0 ..< numberLine.visible.count) { number in
                    if self.numberLine.visible[number] {
                        Text(String(number)).font(.title).padding(5)
                    }
                }

A: With `@ObservedObject` everything's fine... let's analyse...

**Iteration 1:**

Take your code without changes and add just the following line (shows as text current state of `visible` array)

```
VStack { // << right below this
    Text("\(numberLine.visible.reduce(into: "") { $0 += $1 ? "Y" : "N"} )")
```

and run, and you see that `Text` is updated so observable object works

![MvL8C](https://user-images.githubusercontent.com/62171579/163551857-fd6d64e0-06dc-46a3-ab16-4cdf3449f7e5.gif)


**Iteration 2:**

Remove `self.numberLine.objectWillChange.send()` and use instead default `@Published` pattern in view model

```
class NumberLinex: ObservableObject {
    @Published var visible: [Bool] = Array(repeatElement(true, count: 10))
}
```

run and you see that update works the same as on 1st demo above. 

*But... main numbers in `ForEach` still not updated... yes, because problem in `ForEach` - you used constructor with `Range` that generates **constant** view's group **by-design** (that documented!). 

!! That is the reason - you need dynamic `ForEach`, but for that model needs to be changed.

**Iteration 3 - Final:**

Dynamic `ForEach` constructor requires that iterating data elements be identifiable, so we need struct as model and updated view model.

Here is final solution & demo (tested with Xcode 11.4 / iOS 13.4)

![mUIBn](https://user-images.githubusercontent.com/62171579/163551893-9ffbb965-f880-4229-9995-ae28ba43e72b.gif)


```swift
struct ContentView: View {

    @ObservedObject var numberLine = NumberLine()

    var body: some View {
        VStack {
            HStack {
                ForEach(numberLine.visible, id: \.id) { number in
                    Group {
                        if number.visible {
                            Text(String(number.id)).font(.title).padding(5)
                        }
                    }
                }
            }.padding()

            Button("Change") {
                let index = Int.random(in: 0 ..< self.numberLine.visible.count)
                self.numberLine.visible[index].visible.toggle()
            }.padding()
        }
    }
}

class NumberLine: ObservableObject {
    @Published var visible: [NumberItem] = (0..<10).map { NumberItem(id: $0) }
}

struct NumberItem {
    let id: Int
    var visible = true
}
```

