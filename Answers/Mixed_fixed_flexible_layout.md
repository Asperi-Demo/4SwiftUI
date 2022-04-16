```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: In SwiftUI, is there a simple way to size the children with non-fixed size as a factor of remaining space available? (Flex Factor) (by Tiago Peres França)

A: In layout it is important to place needed containers. In the considered case there is two fixed UI elements so we can use that
to simplify layout and place `GeometryReader` only for three of them calculating only first flexible, because all others will
be known (because 2nd is defined, and 4th just should get *everything else*)

Tested with XCode 13.3 / iOS 15.4

![Screenshot 2022-04-16 at 10 44 50](https://user-images.githubusercontent.com/62171579/163666687-0d017094-2960-4175-b3ae-aea65fdb497c.png)


```
  // Color elements below is used for simplicity of demo, because they by-design automatically fill
  // available space, so we can exclude not important modifiers
  
  let fixed1: CGFloat = 100
  let fixed2: CGFloat = 140

  var body: some View {
    HStack(spacing: 0) {
      Color.red
        .frame(width: fixed1)  // << known fixed

      GeometryReader { gp in
        HStack (spacing: 0) {
          Color.green
              .frame(width: (gp.size.width - fixed2) * 2/3)  // << calculable !!
          Color.blue
            .frame(width: fixed2) // << known fixed
          Color.purple   // << fills remaining
        }
      }

    }
    .background(Color.gray)
    .frame(maxWidth: .infinity, maxHeight: 50)
  }
```

[Full test module is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestMixedHorizontalLayout.swift)
