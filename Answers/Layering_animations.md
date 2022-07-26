```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Layering iOS Animations (by cramos24)

A: Here is a possible solution - the main idea is to separate animations by value and make them serial. Tested with Xcode 12 / iOS 14

![vRY06](https://user-images.githubusercontent.com/62171579/180129474-18cd3da5-d592-4569-a9c7-846141de13c6.gif)

```
struct ContentView: View {
    @State var recordComplete = false
    @State private var rCorner: CGFloat = 100
    @State private var rWidth: CGFloat = 70
    @State private var rHeight: CGFloat = 70
    @State private var opacityVal = 1.0

    var body: some View {
        HStack{
            Button(action: {
                self.rCorner = self.rCorner == 100 ? 12 : 100
                self.rWidth = self.rWidth == 70 ? 45 : 70
                self.rHeight = self.rHeight == 70 ? 45 : 70

                self.recordComplete.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.opacityVal = self.recordComplete ? 0.3 : 1.0
                }
            }) {
                ZStack{
                    Circle()
                        .stroke(Color.red, lineWidth: 6)
                        .frame(width:85, height: 85)


                    RoundedRectangle(cornerRadius: rCorner)
                        .fill(Color.red)
                        .frame(width: rWidth, height: rHeight)
                        .opacity(opacityVal)
                        .animation(
                            self.recordComplete ?
                                Animation.easeInOut(duration: 1).repeatForever(autoreverses: true) :
                                Animation.default,
                            value: opacityVal)
                }
                .padding(.vertical, 25)

            }
        }.animation(.spring(response: 0.5, dampingFraction: 2, blendDuration: 0.5), value: rCorner)
    }
}
```
