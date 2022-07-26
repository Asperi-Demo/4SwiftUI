```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI view with multiple ViewBuilder (by Jan)

A: If we mean notation like the following (kind of internal view DSL)

```
ThreeItemView {
    Start {
        Image(systemName: "envelope.fill")
    }
    Main {
        Text("Main")
    }
    End {
        Image(systemName: "chevron.right")
    }
}
```

then the simplified approach can be as follows:

```
typealias Start<V> = Group<V> where V:View
typealias Main<V> = Group<V> where V:View
typealias End<V> = Group<V> where V:View

struct ThreeItemView<V1, V2, V3>: View where V1: View, V2: View, V3: View {

    private let content: () -> TupleView<(Start<V1>, Main<V2>, End<V3>)>

    init(@ViewBuilder _ content: @escaping () -> TupleView<(Start<V1>, Main<V2>, End<V3>)>) {
        self.content = content
    }

    var body: some View {
        let (start, main, end) = self.content().value
        return HStack {
            start
            main
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            end
        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 60, alignment: .leading)
    }
}

struct ThreeItemContainer_Previews: PreviewProvider {
    static var previews: some View {

        ThreeItemView {
            Start {
                Image(systemName: "envelope.fill")
            }
            Main {
                Text("Main")
            }
            End {
                Image(systemName: "chevron.right")
            }
        }
    }
}
```
