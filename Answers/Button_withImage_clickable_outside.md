```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - Button with Image is clickable outside (by stefOCDP)

A: The `.clipped` affects only drawing, and by-default `Button` has all content clickable not depending what it is.

So if you want make your button clickable only in image area, you have to limit hit testing only to its rect explicitly and disable everything else.

Here is a demo of possible approach. Tested with Xcode 11.4 / iOS 13.4.

![BGbID](https://user-images.githubusercontent.com/62171579/165812659-3ca374a4-c61b-4132-abcc-673347cb5b04.gif)

Demo code (simplified variant of your snapshot):

```swift
struct ButtonCard: View {

    var body: some View {
        VStack {
            Image("sea")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 250, alignment: .center)
                .cornerRadius(12)
                .contentShape(Rectangle())    // << define clickable rect !!
                .clipped()

            HStack {
                Text("Image #1")
                    .font(.system(size: 18))
                    .bold()
                    .kerning(0.5)

                Spacer()
            }.allowsHitTesting(false)         // << disable label area !!
        }
        .padding(2)
        .border(Color(.systemRed), width: 2)
    }
}

struct TestClippedButton: View {
    var body: some View {
        Button(action: { print(">> tapped") }) {
            ButtonCard()
        }.buttonStyle(PlainButtonStyle())
    }
}
```
