```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: How to make GridItem pushing out to fill the available space (by LukeSideWalker)

A: The `GridItem` is filled/aligned according to the size of content, but the `Rectangle` has no own size, so you see used some minimum default values.

Here is a possible solution (tested with Xcode 12 / iOS 14)

![SrYIc](https://user-images.githubusercontent.com/62171579/170755805-0499abc4-78f3-4299-bf9b-7bea18a36da8.png)

```
struct AllAchievementsView: View {
    
    let sp = CGFloat(5)
    var gridRows: Array<GridItem> { Array(repeating: GridItem(spacing: sp), count: 4) }

    var body: some View {
        
    GeometryReader { gp in
      ZStack {
          Color.black
          LazyHGrid(rows: gridRows, spacing: sp) {
             ForEach(0..<24) { index in
                RoundedRectangle(cornerRadius: 10).foregroundColor(.blue)
                .frame(width: gp.size.width / 6 - 2*sp)
             }
          }
          .padding()
      }
    }
    }
}
```
