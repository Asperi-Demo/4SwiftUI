```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI grid with column that fits content? (by Rob N)

A: It is not so complex if to compare number of code lines to make this programmatically in both worlds...

Anyway, sure it is possible. Here is a solution based on some help modifier using view preferences feature. No hard. No grid.

Demo prepared & tested with Xcode 12 / iOS 14. 

![91Mdy](https://user-images.githubusercontent.com/62171579/173861424-2b9707dc-a3cc-428f-9f35-779604a55fd6.png)

```
struct DemoView: View {
  @State private var width = CGFloat.zero

    var body: some View {
    VStack {
      HStack {
        Text("Label1")
          .alignedView(width: $width)
        TextField("", text: .constant("")).border(Color.black)
      }
      HStack {
        Text("Bigger Label")
          .alignedView(width: $width)
        TextField("", text: .constant("")).border(Color.black)
      }
    }
    }
}
```

and helpers

```
extension View {
    func alignedView(width: Binding<CGFloat>) -> some View {
        self.modifier(AlignedWidthView(width: width))
    }
}

struct AlignedWidthView: ViewModifier {
    @Binding var width: CGFloat

    func body(content: Content) -> some View {
        content
            .background(GeometryReader {
                Color.clear
                    .preference(key: ViewWidthKey.self, value: $0.frame(in: .local).size.width)
            })
            .onPreferenceChange(ViewWidthKey.self) {
                if $0 > self.width {
                    self.width = $0
                }
            }
            .frame(minWidth: width, alignment: .trailing)
    }
}
```
