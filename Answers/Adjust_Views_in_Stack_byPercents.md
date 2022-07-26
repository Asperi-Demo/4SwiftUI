```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI Adjusting frame size of VStacks by percent height (by aturan23)

A: Here is calculable relative layout solution based on `GeometryReader` (*Note: using NSScreen is inappropriate in such case as might introduce expected layout on different models*)

Tested with Xcode 12b

![M1EvV](https://user-images.githubusercontent.com/62171579/166146022-1b046234-8a13-4761-8a62-58f5ecd12eb5.png)

```
struct CardView: View {
    var body: some View {
        GeometryReader { gp in
            VStack {
                VStack {
                    Text("Blue")
                }
                .frame(width: gp.size.width, height: gp.size.height * 0.7)
                .background(Color.blue)
                VStack {
                    Text("Red")
                }
                .frame(width: gp.size.width, height: gp.size.height * 0.3)
                .background(Color.red)
            }
        }
        .frame(height: 280).frame(maxWidth: .infinity)
        .cornerRadius(24).padding(.horizontal, 30)
    }
}
```
