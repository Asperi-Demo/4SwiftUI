```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Is there a way to set a fullScreenCover background opacity? (by Aswath)

A: Here is possible solution

            .fullScreenCover(isPresented: $present) {
                VStack(spacing: 20) {
                    Spacer()
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color.black)
                        .opacity(0.3)
                    
                    Text("modal")
                }
                .background(BackgroundCleanerView())     // << helper !!
            }


and now helper

```
struct BackgroundCleanerView: UIViewRepresentable {
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
