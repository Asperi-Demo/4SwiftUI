```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: TabView does not respect selection binding when displayed modally (by Chris)

A: The reason is not in modality (ie showing in sheet), but in that `TabView` does not read initial (!) selection (and this is definitely a SwiftUI bug)

Here is workaround (tested with Xcode12 / iOS 14 on replicated code)

![ZbhUv](https://user-images.githubusercontent.com/62171579/170696328-e6c576b1-10cb-4c9e-8705-e9e4894ca320.gif)

```
struct SlideshowView: View {
    @Binding var selection: Int
    var assets: [String]
    var body: some View {
        TabView(selection: $selection) {
            ForEach(assets.indices, id: \.self) { index in
                Image(assets[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onAppear {
            // WORKAROUND: simulate change of selection on appear !!
            let value = selection
            selection = -1
            DispatchQueue.main.async {
                selection = value
            }
        }
    }
}

// for testing
struct ContentView: View {
    let assets: [String] = (1...32).map { "preview_\($0)"}
    
    @State private var selection: Int = 0
    @State private var isPresented: Bool = false
    var body: some View {
        VStack {
            Button("Random element") {
                selection = Int.random(in: 1...32)
                isPresented = true
            }
        }
        .sheet(isPresented: $isPresented) {
            SlideshowView(selection: $selection, assets: assets)
        }
    }
}

```
