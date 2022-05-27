```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI WidgetKit: How to anchor views to the top (by Koh)

A: Here is possible layout solution. Tested with Xcode 12.


![pngGz](https://user-images.githubusercontent.com/62171579/170765626-2b305dbe-0758-4e22-9f1f-340ce4f5caf6.png)

```
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("FAVOURITES")
          .bold()
          .frame(height: 8)
        Spacer()
      }
      .padding()
      .background(Color.blue)
      
      Color.clear
        .overlay(
          LazyVStack {
            ForEach(places, id: \.self) { place in
              PlaceRow(place: place)
            }
          },
          alignment: .top)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
```
