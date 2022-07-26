```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Rectangle overlay on hovering a custom button (by remarkies)

A: Here is a solution. Tested with Xcode 11.4.

![nAqhj](https://user-images.githubusercontent.com/62171579/172101063-70966e94-806e-43cf-a411-098937628ba6.gif)

```
struct TestOnHoverButton: View {
    var body: some Vieaw {
        Button("Button") {}
            .buttonStyle(CustomButtonStyle())
    }
}

struct CustomButtonStyle: ButtonStyle {

    private struct CustomButtonStyleView<V: View>: View {
        @State private var isOverButton = false

        let content: () -> V

        var body: some View {
            ZStack {
                content()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
            }
            .padding(3)
            .onHover { over in
                self.isOverButton = over
                print("isOverButton:", self.isOverButton, "over:", over)
            }
            .overlay(VStack {
                if self.isOverButton {
                    Rectangle()
                        .stroke(Color.blue, lineWidth: 2)
                } else {
                    EmptyView()
                }
            })
        }
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        CustomButtonStyleView { configuration.label }
    }
}
```
