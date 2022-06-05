```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Timer onReceive not working inside NavigationView (by Arturo)

A: It is better to attach observers to non-conditional views, like

```
    var body: some View {
        NavigationView{
            VStack {
                if(self.timeRemaining > 0) {
                    Text("\(timeRemaining)")
                } else {
                    Text("Time is up!")
                }
            }
            .onReceive(timer) { _ in        // << to VStack
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
            }
        }
    }
```

**Update:** some thoughts added (of course SwiftUI internals are known only for Apple).

.onReceive must be attached to persistently present view in NavigationView, the reason is most probably in conditional ViewBuilder and internal of NavigationView wrapper around UIKit UINavigationControler.

> if you remove the condition and have a single Text view with onReceive inside the VStack inside the NavigationView, nothing is ever received

If after condition removed it is attached to `Text("\(timeRemaining)")` then all works (tested with Xcode 11.4), because there is state dependency in body.

If it is attached to constant Text then there is nothing changed in body, ie. dependent on changed state - `timeRemaining`, so SwiftUI rendering engine interprets body as static.
