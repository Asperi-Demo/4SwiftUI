```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I make a background color with opacity on a Sheet view? (by Tio)

A: You cannot do it with standard sheet official API (because every hosting controller view by default is 
opaque), so you can either create custom sheet view (with any features you needed) or use run-time 
workaround to find that view and set its background to clear. Like below (*only for demo*)

![WcKtX](https://user-images.githubusercontent.com/62171579/163782182-9fe19891-2012-4661-bdb4-9be741a2f090.png)


```
struct DemoView: View {

    @State var isSheet = false

    var body: some View {

        Button(action: {self.isSheet.toggle()}) {
            Text("Sheet")
        }.sheet(isPresented: $isSheet){
            Color.yellow.opacity(0.5)
                .background(BackgroundClearView())
        }
    }
}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
```
