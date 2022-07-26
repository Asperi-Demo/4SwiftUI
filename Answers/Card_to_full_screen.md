```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: ForEach and GeometryReader: variable height for children? (by lorem_stack)

A: > Ultimately, I want to recreate the expanded card view of the app store: imgur.com/a/1Jd4bI5. I already posted an other Stackoverflow question for this: stackoverflow.com/questions/62331530/…. Everything works except having cards with differenz sizes.

Ok, I used code from that accepted post as entry point (as you said it satisfies you except different height support)

So here is a solution to support different height cells in that code using view preferences.

Tested with Xcode 12b (however I did not use SwiftUI2 features, just in case).

![prnpH](https://user-images.githubusercontent.com/62171579/174467552-910a8789-52e8-4bb6-80ae-2261a799a54a.gif)

Only changed part:

```
struct ContentView: View {
    @State var selectedForDetail : Post?
    @State var showDetails: Bool = false

    // Posts need to be @State so changes can be observed
    @State var posts = [
        Post(subtitle: "test1", title: "title1", extra: "Lorem ipsum dolor..."),
        Post(subtitle: "test1", title: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor", extra: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor..."),
        Post(subtitle: "test1", title: "title1", extra: "Lorem ipsum dolor..."),
        Post(subtitle: "test1", title: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis", extra: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis..."),
        Post(subtitle: "test1", title: "title1", extra: "Lorem ipsum dolor...")
    ]

    @State private var heights = [Int: CGFloat]()   // store heights in one update
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.posts.indices) { index in
                    GeometryReader { reader in
                        PostView(post: self.$posts[index], isDetailed: self.$showDetails)
                            .fixedSize(horizontal: false, vertical: !self.posts[index].showDetails)
                            .background(GeometryReader {
                                Color.clear
                                    .preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
                            })
                            .offset(y: self.posts[index].showDetails ? -reader.frame(in: .global).minY : 0)
                            .onTapGesture {
                                if !self.posts[index].showDetails {
                                    self.posts[index].showDetails.toggle()
                                    self.showDetails.toggle()
                                }
                            }
                            // Change this animation to what you please, or change the numbers around. It's just a preference.
                            .animation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0))
                            // If there is one view expanded then hide all other views that are not
                            .opacity(self.showDetails ? (self.posts[index].showDetails ? 1 : 0) : 1)
                    }
                    .frame(height: self.posts[index].showDetails ? UIScreen.main.bounds.height : self.heights[index], alignment: .center)
                    .onPreferenceChange(ViewHeightKey.self) { value in
                        self.heights[index] = value
                    }
                    .simultaneousGesture(
                        // 500 will disable ScrollView effect
                        DragGesture(minimumDistance: self.posts[index].showDetails ? 0 : 500)
                    )
                }
            }
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
```
