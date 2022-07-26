```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Simple SwiftUI transition that doesn't seem to be working (by rayaantaneja)

A: Transition is an engine to *present/remove* a view in/from view hierarchy (with animation if animation is specified). It is applied to view as a whole, directly, and is not *passed-into* view's subviews. So if you try to add view into view hierarchy that does not have own transition it just appears, immediately, if there is animation then by default fade-in/out transition is applied (again, to view *as a whole*).

But you want to transition view's internals from outside. So here is possible solution.

Tested with Xcode 11.4 / iOS 13.4 (you can play with animations by yourself)

![eoh22](https://user-images.githubusercontent.com/62171579/180131120-b9d791ae-cc12-4a05-87ec-366a459f7d15.gif)

```
struct Test: View {
    @State private var pressed = false

    var body: some View {
        VStack {
            Button(pressed ? "Press me to hide tower" : "Press me to show tower") {
                self.pressed.toggle()
            }

            Tower(show: $pressed)
        }.animation(.easeInOut)
    }
}

struct Tower: View {
    @Binding var show: Bool
    var body: some View {
        VStack {
            if show {
                Text("Level 3").transition(.move(edge: .leading))
                Text("Level 2")
                Text("Level 1").transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut)
    }
}
```
