```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to apply .onHover to individual elements in SwiftUI (by Isaac)

A: It needs to change onHover view on per-view base, ie. store some identifier of hovered view. 

Here is possible solution. Tested with Xcode 11.4.

![1z9RC](https://user-images.githubusercontent.com/62171579/170929864-093211a6-4a4a-4ae0-b64d-9273897c3ed7.gif)

```
struct TestOnHoverInList : View {
    @State var hovered: (Int, Int) = (-1, -1)
    var body: some View {
        VStack(spacing: 90) {
            ForEach(0..<2) {i in
                HStack(spacing: 90) {
                    ForEach(0..<4) {j in
                        Circle().fill(Color.red).frame(width: 50, height: 50)
                        .scaleEffect(self.hovered == (i,j) ? 2.0 : 1.0)
                        .animation(.default)
                        .onHover { hover in
                            print("Mouse hover: \(hover)")
                            if hover {
                                self.hovered = (i, j)    // << here !!
                            } else {
                                self.hovered = (-1, -1)  // reset
                            }
                        }
                    }
                }
            }
        }
        .frame(minWidth:300,maxWidth:.infinity,minHeight:300,maxHeight:.infinity)
    }
}
```
