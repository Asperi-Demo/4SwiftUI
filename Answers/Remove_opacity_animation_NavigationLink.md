```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to remove opacity animation in SwiftUI NavigationLink (by santi.gs)

A: Here is possible solution. Tested with Xcode 11.4 / iOS 13.4

Use custom button style that just returns label view (w/o highlight effect)

```
struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
```

and

        NavigationLink(destination: DetailView()){
            HStack{
                Text("title")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
        }.buttonStyle(FlatLinkStyle())     // << here !!
