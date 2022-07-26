```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - Change opacity of a view based on position of scrollview (by Jason Tremain)

A: Here is a demo of idea.

![BTwWC](https://user-images.githubusercontent.com/62171579/175787189-40893b9b-fcaa-4006-a3bd-fd9fab779e41.gif)

The code just shows the approach and due to simplicity it can be easily integrated/transferred. All background colors is just for better visibility, as well as calculation might be more complex and included animations, but the idea kept the same - it is possible to read rect of image in global coordinates using `GeometryProxy` and depending on that change opacity of some other view via corresponding `@State`.

    struct TestScrollDependentOpacity: View {
    
        @State private var barOpacity: Double = 0
    
        var body: some View {
            ZStack(alignment: .top) {
                mainContent
                floatingBar
            }
        }
    
        private var mainContent: some View {
            ScrollView {
                GeometryReader { g -> AnyView in
                    let rect = g.frame(in: .global)
                    DispatchQueue.main.async {
                        self.barOpacity = rect.maxY < 0 ? 0.5 : 0.0
                    }
                    return AnyView(Image(systemName: "sun.max")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .position(x: g.size.width / 2.0, y: g.size.height / 2.0))
                }
                .frame(height: 100).background(Color.yellow)
    
                VStack(alignment: .leading) {
                    ForEach (0..<40) { i in
                        HStack {
                            Text("Text \(i)").padding()
                            Spacer()
                        }
                    }
                }.background(Color.green)
            }
        }
    
        private var floatingBar: some View {
            HStack {
                Button("Left") { }
                Spacer()
                Button("Right") { }
            }
            .padding()
            .background(Color.white.opacity(barOpacity))
            .edgesIgnoringSafeArea(.top)
        }
    }
    
