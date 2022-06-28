```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Why does my Button style object only work on the text within the button and not the entire button? (by mogoco8594)

A: The solution is to make background as part of a button style as shown below.

Tested with Xcode 11.4 / iOS 13.4

![LnVbE](https://user-images.githubusercontent.com/62171579/176180238-198ec663-5b8c-4f77-a5c6-ff18e70eb3e0.gif)

```
struct ScaleButtonStyle: ButtonStyle {
    let bgColor: Color
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(bgColor)
            .scaleEffect(configuration.isPressed ? 5 : 1)
    }
}

struct TestScaleButtonStyle: View {
    var body: some View {
        Button(action: { }) {
            Text("Button")
                .foregroundColor(.white)
        }.buttonStyle(ScaleButtonStyle(bgColor: Color.red))
    }
}
```
