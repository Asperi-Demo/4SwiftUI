```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Cross navigation with NavigationView (by vasily)

A: The `NavigationView` manger links on per-level base, so modifying other stack level can result it unexpected behaviour.

Here is a solution for the described use-case. Tested with Xcode 11.4 / iOS 13.4

```
struct TestNavigationByEnum: View {
    @State var page: Page? = nil
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Chapter1(page: self.$page),
                               tag: .chapter1,
                               selection: self.$page) {
                    Text("Chapter 1")
                }.isDetailLink(false) // important !!

                NavigationLink(destination: Chapter2(page: self.$page),
                               tag: .chapter2,
                               selection: self.$page) {
                    Text("Chapter 2")
                }.isDetailLink(false)
            }
        }
    }
}

struct Chapter1: View {
    @Binding var page: Page?
    var body: some View {
        VStack {
            Button("Back to Overview") {
                self.page = nil
            }
            // own level link
            NavigationLink(destination: Chapter2(page: self.$page)) {
                Text("Chapter 2")
            }.isDetailLink(false)
        }
    }
}
```
