```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to change PageTabView programmatically in iOS 14, SwiftUI 2? (by Azhagusundaram Tamil)

A: Here is a demo of solution - just to add selection state and change it where/when it is needed (w/ or w/o animation). 

Tested with Xcode 12 / iOS 14

![i2Idz](https://user-images.githubusercontent.com/62171579/163841373-dc3c520a-94ce-4134-a96b-d91ed873e685.gif)


```
struct OnBoardingView: View {
    @State private var selectedPage = 0
    var body: some View {
        VStack {
            HStack {
                Button("<") { if selectedPage > 0 {
                    withAnimation { selectedPage -= 1 }
                } }
                Spacer().frame(width: 40)
                Button(">") { if selectedPage < 2 {
                    withAnimation { selectedPage += 1 }
                } }
            }
            TabView(selection: $selectedPage) {
                Text("Hi").tag(0)
                Text("Hello").tag(1)
                Text("Welcome").tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}
```
