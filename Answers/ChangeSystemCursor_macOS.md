Q: How to change the cursor to a crosshair in SwiftUI on MacOS (by Jacob Shooter)

A: It is not the way how `NSCursor` works. There is a stack of cursors so any standard (or non-standard) control can push own type of cursor on top and make that cursor current. So you just place first cursor, but then some standard view having own default cursor replaces it.

As SwiftUI does not allow now to manage cursors natively, the solution might be 

a) either to set/push desired cursor on SwiftUI view appear/disappear, or 

b) add cursor rect to `NSHostingController` view using standard `NSView.addCursorRect` method.

**Update:** some quick demo from existing project (part of custom button solution)

![rOlER](https://user-images.githubusercontent.com/62171579/164744376-ff759fdd-c939-4759-882e-0e96efab9aba.gif)

```
struct DemoCustomCursor: View {
    var body: some View {
        Button(action: {}) {
            Text("Cross Button")
                .padding(20)
                .background(Color.blue)
        }.buttonStyle(PlainButtonStyle())
        .onHover { inside in
            if inside {
                NSCursor.crosshair.push()
            } else {
                NSCursor.pop()
            }
        }
    }
}
```
