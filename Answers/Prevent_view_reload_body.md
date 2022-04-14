```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI how to prevent view to reload whole body (by Vkukjans)

A: SwfitUI has a pattern for this. It needs to conform custom view to `Equatable` protocol

    struct CustomView: View, Equatable {
    
        static func == (lhs: CustomView, rhs: CustomView) -> Bool {
            // << return yes on view properties which identifies that the
            // view is equal and should not be refreshed (ie. `body` is not rebuilt)
        }
    ...

and in place of construction add modifier `.equatable()`, like

    var body: some View {
          CustomView().equatable()
    }

yes, new value of `CustomView` will be constructed every time as superview refreshing (so *don't make `init` heavy*), but `body` will be called **only if newly constructed view is not equal of previously constructed**

Finally, it is seen that it is very useful to break UI hierarchy to many views, it would allow to optimise refresh a lot (but not only good design, maintainability, reusability, etc. :^) ).
