```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Offset doesn't reset after onTapGesture - SwiftUI (by L. Sherbini)

A: Applied properties does not reset magically by themselves - you need to change them as/when needed. 

Here is simplest possible solution. Tested with Xcode 11.4 / iOS 13.4

![tkEZ3](https://user-images.githubusercontent.com/62171579/171129961-b3ec167f-7d8c-43e0-a1b0-d4149f137ded.gif)

```
var body: some View {
    VStack {
        ZStack {
            Rectangle()
                .fill(Color.green)
                .frame(height: 300)

            Rectangle()
                .fill(Color.red)
                .frame(width: 290, height: 64)
                .offset(y: tapped ? 118 : 0)
                .onTapGesture {
                    self.tapped.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.tapped.toggle()
                    }
            }
            .animation(Animation.easeInOut(duration: 0.5))
        }

        Spacer()
    }.edgesIgnoringSafeArea(.all)
}
```
