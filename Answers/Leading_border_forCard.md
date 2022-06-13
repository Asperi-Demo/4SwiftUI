```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How do I create a leading border for a view with cornerRadius in SwiftUI? (by Serge Vu)

A: Here is a demo of possible approach - using mask in overlay (also shown how to make button clickable if there will be some in card)

Tested with Xcode 12.1 / iOS 14.1

![Bbc4r](https://user-images.githubusercontent.com/62171579/173292753-a6633b57-b8f6-454c-907c-434e07740a54.png)

```
struct DemoView: View {
  var body: some View {
    VStack(alignment: .leading) {
       Text("Top text").font(.title2).bold()
       Spacer()
       Button("Bottom text") {}
    }
    .padding()
    .background(Color.white)
    .cornerRadius(10)
    .shadow(radius: 5)
    .overlay(
          RoundedRectangle(cornerRadius: 10).fill(Color.red).mask(    // << here !!
      HStack {
        Rectangle().frame(width: 10)
        Spacer()
      }
    ).allowsHitTesting(false))   // << make click-through
    .frame(height: 200)
  }
}
```
