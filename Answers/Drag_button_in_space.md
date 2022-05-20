Q: How to make a button draggable/movable with SwiftUI? (by abcdefg)

A: Here is a demo of possible approach. Tested & works with Xcode 11.4 / iOS 13.4

### Update: re-tested with Xcode 13.3 / iOS 15.4

![GKcqL](https://user-images.githubusercontent.com/62171579/169559382-e8510a1d-fa21-4f3b-b089-17e18bdc06d7.gif)

See also notes inline.

```
struct CircleButton: View {
    @State private var dragAmount: CGPoint?
    var body: some View {
        GeometryReader { gp in // just to center initial position
            ZStack {
                Button(action: self.performAction) {
                    ZStack {
                        Circle()
                            .foregroundColor(.blue)
                            .frame(width: 100, height: 100)
                        Text("Move me")
                            .foregroundColor(.white)
                            .font(.system(.caption, design: .serif))
                    }
                }
                 // Use .none animation for glue effect
                .animation(.default, value: dragAmount)
                .position(self.dragAmount ?? CGPoint(x: gp.size.width / 2, y: gp.size.height / 2))
                .highPriorityGesture(  // << to do no action on drag !!
                    DragGesture()
                        .onChanged { self.dragAmount = $0.location})
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // full space
        }
    }

    func performAction() {
        print("button pressed")
    }
}
```
