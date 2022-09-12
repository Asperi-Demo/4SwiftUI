>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Tile a rectangle with a custom shape in SwiftUI (by Paboka)

A: Say the `Image` has own content size, so can be tiled as-is, but the `Shape` by design has no own size and fill all provided rectangle, so it is needed to specify which size to use for tiles.

Here is possible solution. Tested with Xcode 12 / iOS 14

![1cNG4](https://user-images.githubusercontent.com/62171579/189692739-b04d6778-807b-4252-bf7c-c125cc40541a.png)

```
struct DemoShapeTiling: View {
    var body: some View {
        Rectangle().fill(Color.blue)
            .tile(Circle(), of: CGSize(width: 40, height: 40))
            .foregroundColor(.red)
            .clipped()
    }
}

struct TilingShape<S: Shape>: Shape {
    let shape: S
    let size: CGSize

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for x in stride(from: CGFloat.zero, to: rect.size.width, by: size.width) {
            for y in stride(from: CGFloat.zero, to: rect.size.height, by: size.height) {
                let r = CGRect(origin: CGPoint(x: x, y: y), size: size)
                path.addPath(shape.path(in: r))
            }
        }
        return path
    }
}

extension View {
    public func tile<S: Shape>(_ shape: S, of size: CGSize) -> some View {
        self.overlay(TilingShape(shape: shape, size: size))
    }
}
```
