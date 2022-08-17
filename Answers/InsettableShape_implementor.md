>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How can I return some InsettableShape Protocol in SwiftUI (by ios coder)

A: Ok, the task is to convert all those different value-types to one single, so we need a non-generic 
type wrapper confirming to `InsettableShape` protocol.

Here is a simplified demo of possible approach. Tested with Xcode 13.2 / iOS 15.2

![e9Bzn](https://user-images.githubusercontent.com/62171579/185077474-fa32246d-dea4-4eba-ad43-6d2b634a78f4.png)

```
struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        test(value: 0)
            .strokeBorder(Color.red, style: StrokeStyle(lineWidth: 50.0, lineCap: .round, lineJoin: .round))
    }
}

func test(value: Int) -> some InsettableShape {
    if (value == 0) {
        return MyInsettableShape { Circle().trim(from: 0, to: 0.5).path(in: $0) }
    }
    else if (value == 1) {
        return MyInsettableShape { Capsule().path(in: $0) }
    }
    else {
        return MyInsettableShape { Rectangle().path(in: $0) }
    }
}

// Shape independent wrapper - possible, because any shape
// can provide a path for specified region rectangle
struct MyInsettableShape: InsettableShape {
    
    private let base: (CGRect) -> Path
    private let inset: CGFloat
    
    init(base: @escaping (CGRect) -> Path, inset: CGFloat = 0) {
        self.base = base
        self.inset = inset
    }
    
    func inset(by amount: CGFloat) -> Self {
        .init(base: base, inset: amount)
    }
    
    func path(in rect: CGRect) -> Path {
        base(rect.inset(by: .init(top: inset, left: inset, bottom: inset, right: inset)))
	}
}
```
