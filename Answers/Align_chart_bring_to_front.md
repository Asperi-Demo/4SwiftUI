```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to ensure view appears above other views when iterating with ForEach in SwiftUI? (by mafarja)

A: The .zIndex have effect for views **within one container**. So to solve this case, as I assume expanded `DataCircle` on click, we need to increase zIndex of entire bar `VStack` per that click by introducing some kind of handling selection.

Here is simplified replicated demo to show the effect

![KcDXT](https://user-images.githubusercontent.com/62171579/171868794-3522dec9-3e31-4529-bc50-dea737246f18.png)

```
struct TestBarZIndex: View {
    @State private var selection: Int? = nil
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("ALL WORKSTATIONS")
                ZStack {
                    Rectangle().fill(Color.yellow)//ChartBackground()
                    HStack(alignment: .bottom, spacing: 15.0) {
                        ForEach(1...10) { number in
                            VStack(spacing: 5) {
                                Spacer()
                                ZStack() { // DataCircle()
                                    Circle().fill(Color.pink).frame(width: 20, height: 20)
                                        .onTapGesture { self.selection = number }
                                    if number == self.selection {
                                        Text("Top Description").fixedSize()
                                    }
                                }
                                Rectangle().fill(Color.green) // ChartBar()
                                    .frame(width: 20, height: CGFloat(Int.random(in: 40...150)))
                                Text("Jun")
                                    .font(.caption)
                            }.zIndex(number == self.selection ? 1 : 0) // << here !!
                            .frame(width: 25.0, height: 200.0, alignment: .bottom)
                            .animation(.default)
                        }
                    }
                }
                .frame(height: 300)
            }
        }
    }
}
```
