>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Force view that conforms to protocol to have a property wrapper in SwiftUI (by Hudi Ilfeld)

```
protocol DismissableView: View {
   var isPresented: Binding<Bool> { get set }
}
```

A: Here are possible variants:

a) use stored property the same as in protocol (drawback: access via `wrappedValue`)

```
struct MyView: DismissableView {

    var isPresented: Binding<Bool>

    var body: some View {
        Text(isPresented.wrappedValue ? "Presented" : "Not")
    }
}
```

2) use internal variable with wrapper to conform to protocol (drawback: needed wrapper in each confirmed view)

```
struct MyView: DismissableView {

	var isPresented: Binding<Bool> {
		get { _presented }
  		set { _presented = newValue }
    }

    @Binding var presented: Bool

// optional init if needed to have MyView(isPresented: Binding<Bool>) interface

//    init(isPresented: Binding<Bool>) {
//       self._presented = isPresented
//    }

    var body: some View {
        Text(presented ? "Presented" : "Not")
    }
}
```

External usage in both cases is same.

Note: the `@Binding var isPresented: Bool` property wrapper being unwrapped creates two properties (see below) that is why you cannot confirm it directly

```
var isPresented: Bool
var _isPresented: Binding<Bool>
```
