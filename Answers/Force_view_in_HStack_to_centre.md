```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to force a specific view in an HStack to be in the centre (by Confused Vorlon)

A: Here is possible simple approach - put Text in center and surround it with some views
which by-default consume remaining space, it can be `Spacer`, `Color`, any `Shape`, etc. Being
layout equally the goal text will be centerred and everything else to the left or right can
be placed as overlays on placeholders:

Tested with Xcode 11.4 / iOS 13.4

![nqwkC](https://user-images.githubusercontent.com/62171579/165099110-69127e86-82fb-4aa8-a614-ee17201c1af4.png)

```
struct DemoHStackOneInCenter: View {
    var body: some View {
        HStack{
            // `Color.clear` also can be used instead of `Spacer()`
            Spacer().overlay(Text("View1"))

            Text("Centre")

            Spacer().overlay(
                HStack {
                    Text("View2")
                    Text("View3")
                }
            )
        }
    }
}
```
