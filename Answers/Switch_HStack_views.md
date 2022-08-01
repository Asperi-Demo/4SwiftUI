>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Is there a way to conditionally flip the order of an HStack's contents? (by Kilian)

A: Here is possible generic approach for any pair of views in any container base on using ViewBuilder. 

Tested with Xcode 12

![JPeY0](https://user-images.githubusercontent.com/62171579/182123917-7115d751-50b3-45fc-ac00-6c19ee6694cb.gif)

```
struct TestHStackFlip: View {
    @State private var flipped = false
    var body: some View {
        VStack {
            HStack {
                FlipGroup(if: flipped) {
                    Text("Text1")
                    Text("Text2")
                }
            }.animation(.default)     // animatable
            Divider()
            Button("Flip") { self.flipped.toggle() }
        }
    }
}

@ViewBuilder
func FlipGroup<V1: View, V2: View>(if value: Bool,
                @ViewBuilder _ content: @escaping () -> TupleView<(V1, V2)>) -> some View {
    let pair = content()
    if value {
        TupleView((pair.value.1, pair.value.0))
    } else {
        TupleView((pair.value.0, pair.value.1))
    }
}
```
