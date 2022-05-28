```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI view preferences: overlayPreferenceValue returns nil when used on complex containers (by msmialko)

A: Preferences are updated during layout and I assume your preference key held `Anchor<CGRect>?` which was reset to nil at the end of layout. 

Here is fixed variant. Tested with Xcode 11.4 / iOS 13.4. 

*Note: I would recommend to use explicit struct model for your custom preference key.

![c1cch](https://user-images.githubusercontent.com/62171579/170831755-af3de20f-9b50-4f65-8193-373db1338194.png)

```
struct BoundsPreferenceKey: PreferenceKey {
    static var defaultValue: [Anchor<CGRect>] = [] // << use something persistent

    static func reduce(value: inout [Anchor<CGRect>], nextValue: () -> [Anchor<CGRect>]) {
        value.append(contentsOf:nextValue())
    }
}

struct debug_test: View {
@State private var someState = false

var body: some View {
    VStack {
        Text("Hello World !!!")
            .anchorPreference(
                key: BoundsPreferenceKey.self,
                value: .bounds
            ) { [$0] }

        if someState {
            Text("Pooop")
        }
        Text("Pooop2")
        //////////////////////////////////////////////////////////
    }
    .overlayPreferenceValue(BoundsPreferenceKey.self) { preferences in
        GeometryReader { geometry in
            preferences.map {
                Rectangle()
                    .stroke(Color.red, lineWidth: 5)
                    .frame(
                        width: geometry[$0].width,
                        height: geometry[$0].height
                )
                    .position(    // << here is fix as well !!
                        x: geometry[$0].midX,
                        y: geometry[$0].midY
                )
            }[0]     // << just for demo, this should be more safe !!
        }
    }
  }
 }
```
