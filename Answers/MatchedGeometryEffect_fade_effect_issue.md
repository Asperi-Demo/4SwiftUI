```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I solve MatchedGeometryEffect fade effect issue in SwiftUI? (by iosDev)

A: The important here is where to apply modifier. A transition should be applied
exactly to the view which is inserted/removed. In the considered scenario the VStack
is removed/inserted but not a Circle, so the transition must be applied to VStack
while the effect is matched by the circles.

![ezgif com-gif-maker-39](https://user-images.githubusercontent.com/62171579/164878755-adf7e086-ba51-4b06-aaf2-ec04ce8d9cb2.gif)

Tested with XCode 13.3 / iOS 15.4

      VStack {
        if update {
          VStack {
            Circle()
              .matchedGeometryEffect(id: "Circle", in: namespaceOfCircle)
              .frame(width: 100, height: 100)
            Spacer()
          }
          .transition(.scale(scale: 1))      // << here !!
        }
        else {
          VStack {
            Spacer()
            Circle()
              .matchedGeometryEffect(id: "Circle", in: namespaceOfCircle)
              .frame(width: 300, height: 300)

          }
          .transition(.scale(scale: 1))       // << here !!
        }
      }

[Test module in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestColorFadeEffect.swift)
