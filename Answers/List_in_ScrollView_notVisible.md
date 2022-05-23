```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI List is not showing any items (by Winten)

A: The `ScrollView` expects dimension from content, but `List` expects dimension from container - as you see there is conflict, so size for list is undefined, and a result rendering engine just drop it to avoid disambiguty.

The solution is to define some size to List, depending of your needs, so ScrollView would now how to lay out it, so scroll view could scroll entire content and list could scroll internal content.

Eg.

![KzWRy](https://user-images.githubusercontent.com/62171579/163792238-6aea0789-76e0-4fd4-96c1-69e64f9fcc1b.png)


```
struct ContentView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight

    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    Text("Some stuff 1")
                    List {
                        Text("one").padding()
                        Text("two").padding()
                        Text("three").padding()
                    }.frame(minHeight: minRowHeight * 3).border(Color.red)
                    Text("Some stuff 2")
                }
            }
        }
    }
}
```
