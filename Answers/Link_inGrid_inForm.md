```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: NavigationLink inside LazyVGrid cycles all entries on back, SwiftUI (by Daniele Bernardini)

A: It is Form/List feature to auto-detect links in rows, but you have several in row, so the effect. The solution would be to separate cell view and hide link from auto-detection.

Tested with Xcode 12.0 / iOS 14

```
struct ContentView: View {
    @State var images:[String] = ["plus", "minus"]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum:100))]){
                        ForEach(images){
                          ImageCellView(image: $0)
                        }
                    }
                }
            }
        }
    }
}

struct ImageCellView: View {
  var image: String
  @State private var isActive = false
  var body: some View {
    Image(uiImage: UIImage(systemName: image)!)
       .resizable()
       .scaledToFit()
      .onTapGesture {
        self.isActive = true
      }
    .background(
       NavigationLink (
          destination: ImageDetail(image: image), isActive: $isActive,
          label: {
            EmptyView()
          }
       ))
  }
}
```
