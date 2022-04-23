```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI Binding default value (Argument labels '(wrappedValue:)' do not match any available overloads) (by Linus)

A: If we need default value on `Binding` property then it can be specified in 
arguments of view init. Here is a demo of approach for constant default value.

```
struct MyView: View {
    @Binding var a: Bool
    init(a: Binding<Bool> = .constant(true)) {
        _a = a
    }

    var body: some View {
        Text("MyView")
    }
}
```
