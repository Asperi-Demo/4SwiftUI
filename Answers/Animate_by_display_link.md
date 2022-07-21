```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to update a view during a CADisplayLink animation (by West1)

A: This is because your `displaylink` is created on stack, so destroyed right after quit from function. You need to make it property.

Here is modified tested code. Tested with Xcode 12 / iOS 14.

![6ot2Q](https://user-images.githubusercontent.com/62171579/180137756-a6e9f104-ef0c-4b72-8045-471e237d569f.gif)

```
class MyAnimations: NSObject, ObservableObject {
    @Published var testX: Double = 0
    @Published var testY: Double = 0

    private var displaylink: CADisplayLink!       // << here !!
    func createDisplayLink() {
        if nil == displaylink {
            displaylink = CADisplayLink(target: self, selector: #selector(step))
            displaylink.add(to: .current, forMode: RunLoop.Mode.default)
        }
    }

    @objc func step(link: CADisplayLink) {
        testX += 0.5
        testY += 0.5
    }

}



struct Squares: View {
    @ObservedObject var animation = MyAnimations()

    var body: some View {
        Path { path in
            path.addRect(CGRect(x: self.animation.testX, y: self.animation.testY, width: 50, height: 50))
        }
        .fill(Color.black)
        .onAppear {
            animation.createDisplayLink()
        }
    }
}
```
