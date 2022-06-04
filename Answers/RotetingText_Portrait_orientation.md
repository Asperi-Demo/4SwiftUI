```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: Text has not the full width of screen after rotation (by kuzdu)

A: Here is a demo of possible approach. Prepared with Xcode 12.1 / iOS 14.1

![qxq1q](https://user-images.githubusercontent.com/62171579/171983758-7f70b43c-3607-41db-8df8-85e704cd5d43.png)

```
struct DemoView: View {
  var body: some View {
    HStack {
      RotatedText(text: lorem, angle: Angle(degrees: 90))
      RotatedText(text: lorem, angle: Angle(degrees: -90))
    }
  }
}

struct RotatedText: View {
  let text: String
  let angle: Angle
  var color: Color = .blue
  
  var body: some View {
    color.overlay(
      GeometryReader { gp in
        VStack {
          Text(text)
            .frame(width: gp.size.height, height: gp.size.width)
            .rotationEffect(angle)
        }.frame(width: gp.size.width, height: gp.size.height)
      }
    )
  }
}
```
