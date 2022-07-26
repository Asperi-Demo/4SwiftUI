```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How Do I Fade the Top or Bottom Edge of a SF Symbol in SwiftUI? (by xp.)

A: Here is my alternate (without UIKit usage)

![gELFF](https://user-images.githubusercontent.com/62171579/170865107-1177eeb3-878c-4915-b3e5-443db75159a1.png)


    struct TestSFSymbolsFade: View {
        var body: some View {
            VStack {
                Image(systemName: "ant.fill").resizable()
                Image(systemName: "ant.fill").resizable()
                Image(systemName: "ant.fill").resizable()
            }
            .mask(LinearGradient(gradient: Gradient(stops: [
                .init(color: .clear, location: 0),
                .init(color: .black, location: 0.25),
                .init(color: .black, location: 0.75),
                .init(color: .clear, location: 1)
            ]), startPoint: .top, endPoint: .bottom))
            .frame(width: 40, height: 160) // < just for demo, can be any or absent
        }
    }

