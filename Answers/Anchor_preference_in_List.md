```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SWiftUI anchorPreference inside List

```
struct ListAndPreferences: View {
    var body: some View {
        List(1..<35) { idx in
            HStack {
                Text("idx: \(idx)")
                
                InnerView(idx: idx)
            }
        }
    }
}
```

A: Actually we don't know how many times on stack SwiftUI can render a body of our custom view, but preferences really required to be written only once (and then they should be transformed, which is more complex).

The possible solution is to use different type of container in Preferences, so values not re-written but accumulated.

Here is modified parts of your code. Tested with Xcode 12.1 / iOS 14.1

```
// use dictionary to store calculated height per view idx
struct CGFloatPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    static func reduce(value: inout [Int: CGFloat] , nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue()) { $1 }
    }
}

struct InnerView: View {
    @State var height: CGFloat = 0
    var idx: Int
    
    var body: some View {
        GeometryReader { proxy in
            generateContent(maxWidth: proxy.frame(in: .global).size.width)
                .anchorPreference(key: CGFloatPreferenceKey.self, value: Anchor<CGRect>.Source.bounds, transform: { anchor in
                    [idx: proxy[anchor].size.height]
                })
        }
        .frame(minHeight: height)
        .onPreferenceChange(CGFloatPreferenceKey.self, perform: { value in
            height = value[idx] ?? .zero
        })
    }
    
    private func generateContent(maxWidth: CGFloat) -> some View {
            VStack {
                HStack {
                    Text("hello")
                        .padding()
                        .background(Color.purple)
                    
                    Text("world")
                        .padding()
                        .background(Color.purple)
                }
            }
            .frame(width: maxWidth)
    }
}

```
