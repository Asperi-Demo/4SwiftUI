>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Prevent padding above Image at top of ScrollView when scrolling beyond limit in Sheet (by Jordan H)

```
struct ContentView: View {
    @State private var sheetVisible = false
    
    var body: some View {
        VStack {
            Button(action: {
                sheetVisible = true
            }, label: {
                Text("Present Sheet")
            })
        }
        .sheet(isPresented: $sheetVisible) {
            DetailsView(image: UIImage(named: "test"))
        }
    }
}
```
A: Here is possible solution. Tested with Xcode 12b5 / iOS 14.

The idea is to have internal container, that scrolls inside, but reading its coordinate in scroll view coordinate space, compensate image position offsetting it relative to container, which continue scrolling, such giving effect that everything else, ie below image, still has bouncing.

![v4AHM](https://user-images.githubusercontent.com/62171579/187022147-d7932f64-3ea5-439b-a076-7582790b80be.gif)

```
struct DetailsView: View {
    var image: UIImage?

    @State private var offset = CGFloat.zero

    var body: some View {
        ScrollView {
            VStack { // internal container
                Image(uiImage: image ?? UIImage())
                    .resizable()
                    .aspectRatio((image?.size.width ?? 1) / (image?.size.height ?? 1), contentMode: .fill)
                    .background(Color(.secondarySystemFill))
                    .offset(y: offset < 0 ? offset : 0)      // compansate offset

                ForEach(0..<50) { index in
                    Text("\(index)")
                }
            }
            .background(GeometryReader {
                // read current position of container inside scroll view
                Color.clear.preference(key: ViewOffsetKey.self,
                    value: -$0.frame(in: .named("scroll")).origin.y)
            })
            .onPreferenceChange(ViewOffsetKey.self) {
                self.offset = $0   // needed offset to shift back image
            }
        }
        .coordinateSpace(name: "scroll")
    }
}
```

See `ViewOffsetKey` in repository sources
