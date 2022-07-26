```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Make ScrollView scrollable only if it exceeds the height of the screen (by ravelinx)

A: Here is a possible approach if a content of scroll view does not require user interaction:

Tested with Xcode 11.4 / iOS 13.4

```
struct StatsView: View {
    @State private var fitInScreen = false
    var body: some View {
        GeometryReader { gp in
            ScrollView {
                VStack {          // container to calculate total height
                    Text("Test1")
                    Text("Test2")
                    Text("Test3")
                    //ForEach(0..<50) { _ in Text("Test") } // uncomment for test
                }
                .background(GeometryReader {
                    // calculate height by consumed background and store in 
                    // view preference
                    Color.clear.preference(key: ViewHeightKey.self,
                        value: $0.frame(in: .local).size.height) })
            }
            .onPreferenceChange(ViewHeightKey.self) {
                 self.fitInScreen = $0 < gp.size.height    // << here !!
            }
            .disabled(self.fitInScreen)
        }
    }
}
```

[ViewHeightKey code in project](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Helpers/PreferenceKeys.swift)
