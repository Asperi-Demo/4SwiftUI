```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Why is my matchedGeometryEffect moving based on bottom right point? (by 2nebin)

A: Find below a fixed view - order of modifiers is important. Tested with Xcode 13 / iOS 14

*Note: Slow Animation is activated for better visibility*

![t0soj](https://user-images.githubusercontent.com/62171579/177003076-d8d5148d-795c-4bff-9779-9d042248e1b9.gif)

```
struct Test: View {
    @Namespace private var ns
    @State var show = false

    var body: some View {
        HStack {
            if show != true {
                Rectangle()
                    .matchedGeometryEffect(id: "animation", in: ns) // << here !!
                    .frame(width: 50, height: 50)
            }
            Spacer()
            Button(action: {
                withAnimation {
                    show.toggle()
                }
            }) {
                Text("Switch")
            }
            Spacer()

            if show {
                Rectangle()
                    .matchedGeometryEffect(id: "animation", in: ns) // << here !!
                    .frame(width: 200, height: 200)
            }
        }
    }
}
```
