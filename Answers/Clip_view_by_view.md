```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: how can I clip a part of a view with another view? (by alionthego)

A: Here is a demo of possible approach with inverted mask (it is simplified but the idea should be clear - removing hardcoding and "bite" position calculations is on you).

Tested with Xcode 13.2 / iOS 15.2

![aqzMT](https://user-images.githubusercontent.com/62171579/168146445-d3518939-319b-4008-975b-1451df7667fa.png)

```
struct DemoView: View {
    struct BiteCircle: Shape {
        func path(in rect: CGRect) -> Path {
            let offset = rect.maxX - 26
            let crect = CGRect(origin: .zero, size: CGSize(width: 26, height: 26)).offsetBy(dx: offset, dy: offset)

            var path = Rectangle().path(in: rect)
            path.addPath(Circle().path(in: crect))
            return path
        }
    }
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(Color.blue)
                .mask(BiteCircle().fill(style: .init(eoFill: true)))     // << here !!
                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 2)

            Circle()
                .frame(width: 22, height: 22)
                .foregroundColor(.blue)
                .offset(x: 18, y: 18)
        }

    }
}
```
