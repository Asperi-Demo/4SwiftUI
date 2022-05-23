```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - Animate height of rectangle from 0 to height (by gnielio)

A: It is needed to use `State` dynamic property to generate and animate
some changes in `View`.

Tested with Xcode 13.3 / iOS 15.4

![ezgif com-gif-maker-37](https://user-images.githubusercontent.com/62171579/162736026-68ed19db-5929-4668-a0c0-d20701d9182f.gif)

```
struct View1: View {
	@State private var height = CGFloat.zero     // << here !!
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            Text("Hola")
                .foregroundColor(.black)
                .font(.headline)
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 100, height: height, alignment: .center)
                .foregroundColor(Color("RedColour"))
                .onShake {
                    withAnimation {
                        height = 100      // << here !!
                    }
                }
        }
    }
}
```
