```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to create a see-through Rectangle in SwiftUI (by Asim Roy)

A: Here is working approach - using custom shape and even-odd fill style.

Tested with Xcode 11.4 / iOS 13.4

Below demo with more transparency contrast for better visibility.

![ZXTFe](https://user-images.githubusercontent.com/62171579/165790738-ca546d50-aa53-4353-bb8e-24c93b3fc00d.png)

```
struct Window: Shape {
    let size: CGSize
    func path(in rect: CGRect) -> Path {
        var path = Rectangle().path(in: rect)

        let origin = CGPoint(x: rect.midX - size.width / 2, y: rect.midY - size.height / 2)
        path.addRect(CGRect(origin: origin, size: size))
        return path
    }
}

struct ImageScope: View {

    var body: some View {
        ZStack {
            Image("test_pic")

            Rectangle()
                .foregroundColor(Color.black.opacity(0.5))
                .mask(Window(size: CGSize(width: 200, height: 150)).fill(style: FillStyle(eoFill: true)))

            RoundedRectangle(cornerRadius: 3).stroke(Color.white, lineWidth: 3)
                .frame(width: 200, height: 150)
        }
    }
}
```
