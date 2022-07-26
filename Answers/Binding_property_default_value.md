```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
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
