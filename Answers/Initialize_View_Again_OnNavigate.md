```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I initialize View Again in SwiftUI? (by Erkam KUCET)

A: It is just needed to defer a destination creation in a builder, and 
the `@ViewBuilder` is a good instrument for this.

It can be used the following wrapper to create a real destination 
only in `body` when it will be rendered (ie. explicitly in time of navigation clicked in this case)

Tested with Xcode 11.4 / iOS 13.4

```
struct DeferView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        content()          // << everything is created here
    }
}
```

and now your builder

```
final class DetailViewBuilder {
    static func make(object: Something) -> some View {
        DeferView {
           DetailView(viewModel: DetailViewModel(object: object))
        }
    }
}
```
