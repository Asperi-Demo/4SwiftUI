```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I create this view in SwiftUI? (by Andy)

A: The problem with applying rotation effect to complex container having many views is that layout of container does not change, so all other views affected by rotated container

It looks more appropriate different approach. The idea is to have plot bars as rectangles where height or rectangle show values, and label is a transformed overlay for such rectangle, thus rectangles form layout, and overlays do not affect anything (almost).

Tested with Xcode 11.4 / iOS 13.4

*Note: the budget line can be added above plot scrollview by wrap both into `ZStack`.*

![nJfkY](https://user-images.githubusercontent.com/62171579/169449732-2d323d33-0d28-4490-9d5d-56bc435e936c.png)

![tiJnR](https://user-images.githubusercontent.com/62171579/169449689-b0f114cb-b81f-4be9-96af-1d3b584d04be.gif)

```
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Title above").font(.largeTitle)
            ContentView()
            Text("comment below")
        }
    }
}


struct ContentView: View {
    var plotHeight: CGFloat = 120

    // test with different lenth labels
    let demos = ["Demo", "Demoos", "Demoooos", "Demooooooos"]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom, spacing: 24) {
                ForEach(0..<20) {_ in
                    Rectangle().foregroundColor(.orange)
                        .frame(width: 14, height: CGFloat.random(in: 0..<self.plotHeight)) // values for demo
                        .overlay(
                            Text(self.demos.randomElement()!) // values for demo
                                .font(.caption)
                                .fontWeight(.bold)
                                .fixedSize()
                                .rotationEffect(Angle(degrees: 270.0), anchor: .leading)
                                .offset(x: -8, y: 6)  // align as/if needed here
                        , alignment: .bottomLeading)
                }
            }
            .frame(height: plotHeight, alignment: .bottom)
            .padding(.leading) // required offset for first label in scrollview
        }
    }
}
```
