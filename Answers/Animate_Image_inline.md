```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Is it possible to change image with fade animation using same Image? (by Mikk)

A: Here is possible approach using *one Image* (for demo some small modifications made to use default images). The important changes marked with comments.

![qfp8B](https://user-images.githubusercontent.com/62171579/169296001-8856bd9d-36be-4d2f-bab5-1863653978b9.gif)

```swift
enum ImageEnum: String {
    case img1 = "1.circle"
    case img2 = "2.circle"
    case img3 = "3.circle"

    func next() -> ImageEnum {
        switch self {
            case .img1: return .img2
            case .img2: return .img3
            case .img3: return .img1
        }
    }
}
struct QuickTest: View {
    @State private var img = ImageEnum.img1
    @State private var fadeOut = false
    var body: some View {
        Image(systemName: img.rawValue).resizable().frame(width: 300, height: 300)
            .opacity(fadeOut ? 0 : 1)
            .animation(.easeInOut(duration: 0.25), value: fadeOut)    // animatable fade in/out
            .onTapGesture {
                self.fadeOut.toggle()                 // 1) fade out

                // delayed appear
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation {
                        self.img = self.img.next()    // 2) change image
                        self.fadeOut.toggle()         // 3) fade in
                    }
                }
            }
    }
}
```
