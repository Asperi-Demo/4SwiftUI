```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI show/hide title issues with NavigationBar (by Simon)

A: Below is a possible approach to hide navigation bar in root view and show in child subviews. The only needed modifications is in root view.

Tested with Xcode 11.4 / iOS 13.4

![q7Jjf](https://user-images.githubusercontent.com/62171579/173517547-cdc3b6b0-6ad7-48a3-824a-733708618384.gif)

Here is a root only, child sub-views are regular and do not require special code for this case. See important notes inline.

```
struct RootNavigationView: View {
    @State private var hideBar = true // << track hide state, and default
    var body: some View {
        NavigationView {
            VStack {
                Text("I'm ROOT")
                Divider()
                NavigationLink("Goto Child", destination: NextChildView(index: 1))
                 .simultaneousGesture(TapGesture().onEnded {
                    self.hideBar = false     // << show, here to be smooth !!
                 })
            }
            .navigationBarHidden(hideBar)
        //    .navigationBarTitle("Back to Root") // << optional 
            .onAppear {
                self.hideBar = true  // << hide on back
            }
        }
    }
}
```
