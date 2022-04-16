```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI add inverted mask (by Garrett Motzner)

A: Here is a demo of possible approach of creating inverted mask, by SwiftUI only, (on example to make a hole in view)
using `Shape` and fill style

![9c6Cx](https://user-images.githubusercontent.com/62171579/163684553-dcfcf371-ac09-46aa-a8db-1f0745f338a9.png)


    func HoleShapeMask(in rect: CGRect) -> Path {
        var shape = Rectangle().path(in: rect)
        shape.addPath(Circle().path(in: rect))
        return shape
    }
    
    struct TestInvertedMask: View {
    
        let rect = CGRect(x: 0, y: 0, width: 300, height: 100) // just for demo
        var body: some View {
            Rectangle()
                .fill(Color.blue)
                .frame(width: rect.width, height: rect.height)
                .mask(HoleShapeMask(in: rect).fill(style: FillStyle(eoFill: true)))
        }
    }
    
