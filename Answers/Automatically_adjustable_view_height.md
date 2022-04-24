```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Automatically adjustable view height based on text height in SwiftUI (by Nace)

A: Here is a solution based on view preference key. `PreferenceKey` (and accompany 
modifiers `.preference`/`.onPreferenceChange`) is a mechanism to transfer
view information from child views to parent **within** body building phase, so updating
state properites in pref key handler does not generate run-time warnings.

Tested with Xcode 11.4 / iOS 13.4

![x8cJw](https://user-images.githubusercontent.com/62171579/164976762-26be8a3c-91ce-4898-9461-22904f60fd45.png)

```
struct DynamicallyScalingView: View {
    @State private var labelHeight = CGFloat.zero     // << here !!

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "snow")
                .font(.system(size: 32))
                .padding(20)
                .frame(minHeight: labelHeight)       // << here !!
                .background(Color.red.opacity(0.4))
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 8) {
                Text("My Title")
                    .foregroundColor(.white)
                    .font(.system(size: 13))
                    .padding(5)
                    .background(Color.black)
                    .cornerRadius(8)
                Text("Dynamic text that can be of different leghts. Spanning from one to multiple lines. When it's multiple lines, the background on the left should scale vertically")
                    .font(.system(size: 13))
            }
            .background(GeometryReader {      // << set right side height
                Color.clear.preference(key: ViewHeightKey.self, 
                    value: $0.frame(in: .local).size.height) 
            })
        }
        .onPreferenceChange(ViewHeightKey.self) { // << read right side height
            self.labelHeight = $0        // << here !!
        }
        .padding(.horizontal)
    }
}
```

[ViewHeightKey is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Helpers/PreferenceKeys.swift)
