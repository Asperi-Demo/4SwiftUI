```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Binding value from an ObservableObject (by user1046037)

A: `Binding` variables can be created in the following ways:

1. `@State` variable's projected value provides a `Binding<Value>`
2. `@ObservedObject` variable's projected value provides a wrapper from which you can get the `Binding<Subject>` for all of it's properties
3. Point 2 applies to `@EnvironmentObject` as well.
4. You can create a Binding variable by passing closures for getter and setter as shown below:

```
let button = SaleButton(isOn: .init(get: { car.isReadyForSale },
                                    set: { car.isReadyForSale = $0} ))
```

**Note:**

- As @nayem has pointed out you need `@State` / `@ObservedObject` /  `@EnvironmentObject` / *`@StateObject` (added in SwiftUI 2.0)* in the view for SwiftUI to detect changes automatically.
- Projected values can be accessed conveniently by using `$` prefix.
