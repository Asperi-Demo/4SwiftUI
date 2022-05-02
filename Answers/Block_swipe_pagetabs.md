```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI TabView PageTabViewStyle prevent changing tab? (by Hoopes)

A: The solution from mentioned reference works, just the swipe is blocked not by `gesture(nil)`, but by `gesture(DragGesture())`. And view should be full-tab-content-view-wide, like

    TabView {
          ForEach(0..<5) { idx in
            Text("Cell: \(idx)")
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .contentShape(Rectangle())
              .gesture(DragGesture())      // this blocks swipe
            //.gesture(isSearching ? DragGesture() : nil)  // blocks by some state condition

          }
        }
        .tabViewStyle(PageTabViewStyle())

Tested with Xcode 12.1 / iOS 14.1
