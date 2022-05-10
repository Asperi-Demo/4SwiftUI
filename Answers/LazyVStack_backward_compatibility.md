```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: typealias LazyVStack for iOS 13 (by keegan3d)

A: Here is possible wrapper that can be used as regular stack container

```
struct CompatibleVStack<Content> : View where Content : View {
    let alignment: HorizontalAlignment
    let spacing: CGFloat?
    let content: () -> Content

    init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil,
            @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
      Group {
        if #available(iOS 14, *) { // << add more platforms if needed
            LazyVStack(alignment: alignment, spacing: spacing, pinnedViews: [], content:content)
        } else {
            VStack(alignment: alignment, spacing: spacing, content:content)
        }
      }
    }
}
```
