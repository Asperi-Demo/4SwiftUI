```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How can I update the location X for offset in exact tap point for a view in SwiftUI?

A: If I correctly understood your goal you need to use `GestureState`. The gesture state has temporary value which reset back to initial once gesture finished.

Here is a demo of possible solution. Prepared with Xcode 12.1 / iOS 14.1

![xeqye](https://user-images.githubusercontent.com/62171579/177712353-fe0eb703-cfd9-4e51-b156-6858211d821a.gif)

```
struct ContentView: View {
    
    @State var locationX: CGFloat = .zero
    @GestureState private var translationX = CGFloat.zero

    let widthOfRec: CGFloat = 200
    
    var body: some View {

        Rectangle()
            .fill(Color.red)
            .frame(width: widthOfRec)
            .border(Color.black)
            .offset(x: locationX + translationX)
            .gesture(
                DragGesture().updating($translationX) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
					locationX += value.translation.width
                }
			)
    }
}
```
