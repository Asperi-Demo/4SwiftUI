```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to center a view vertically and horizontally inside of a container view and put something under it (by ref2111)

A: Here is possible approach (at least for start) that I would prefer, because both labels remains independent, and always be centered in parent container by primary text.



```
struct DemoCenteredText: View {
    var body: some View {
        GeometryReader { gp in
            ZStack {
                Text("Primary Text").font(.title)
                    .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
                    .position(x: gp.size.width / 2, y: gp.size.height / 2)
                Text("Secondary Text")
                    .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.top] - 16 })
            }
        }
    }
}
```

The `.position` in above fixes primary title at center of parent container, which free space is consumed by `GeometryReader`, and `alignmentGuide` force layout to place secondary text at offset 16 from bottom of primary text (actually in the same way as constraint in your question).

