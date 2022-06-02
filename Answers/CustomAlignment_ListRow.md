```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: align views in different HStacks? (by zumzum)

A: Here is a demo of possible approach - based on custom alignment guides, ie. applying same custom alignment guide to different views makes them aligned to/by that guide. (Actually you don't need second `HStack` for this scenario).

Tested with Xcode 12.5 / iOS 14.5

![vxM5y](https://user-images.githubusercontent.com/62171579/171601782-e5fe5e02-8d3e-4627-9d79-e433684ceb95.png)

```
struct ContentView: View {
  var body: some View {
    List(0..<10) {
      RowView(item: $0)
    }
  }
}

extension HorizontalAlignment {
   private enum MyLeadingAlignment: AlignmentID {
      static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
         return dimensions[HorizontalAlignment.leading]
      }
   }
   static let myLeading = HorizontalAlignment(MyLeadingAlignment.self)
}

struct RowView: View {
  let item: Int
  var body: some View {

    VStack(alignment: .myLeading) {
      HStack {
        Text("item: \(item)")
        Text("Some text")
          .alignmentGuide(.myLeading) { $0[.leading] } // << here !!
        Spacer()
      }
      Image(systemName: "squareshape.fill")
        .resizable()
        .frame(width: 30, height: 30)
        .alignmentGuide(.myLeading) { $0[.leading] } // << here !!
    }
  }
}
```
