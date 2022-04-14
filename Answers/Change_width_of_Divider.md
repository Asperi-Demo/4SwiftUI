```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to change width of Divider in SwiftUI? (by mallow)

A: Standard divider is as-is defined by Apple, but if it does not fit our needs, 
we can create any divider we want, colors, width, content... As in below example.


    struct ExDivider: View {
        var color: Color = .gray
        var width: CGFloat = 2
        var body: some View {
            Rectangle()
                .fill(color)
                .frame(height: width)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }

