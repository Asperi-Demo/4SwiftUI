```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: ScrollView Doesn't Scroll with Geometry Reader as Child (by Sergio Diaz)

A: `GeometryReader` is not a regular child and you cannot use it in unknown size area (which is ScrollView), because you got into chicken-egg problem when parent-child expects size of each other.

Instead use internal geometry reader on content background, so content have defined size and you can read its position in other (global) coordinate system, like

    ScrollView (.vertical, showIndicators: false) {
      VStack {
          Text("This is filler text").padding(.vertical, 100)
          Text("This is filler text").padding(.vertical, 100)
          Text("This is filler text").padding(.vertical, 100)
          Text("This is filler text").padding(.vertical, 100)
          Text("This is filler text").padding(.vertical, 100)
      }.background(
         GeometryReader { inner in
              // use proxy here
         })
    }

