```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to close the sheet view, while dismissing that view (by Jerry Lee)

A: As navigation in sheet might be long enough and closing can be not in all 
navigation subviews, I prefer to use environment to have ability to specify 
closing feature only in needed places instead of passing binding via all navigation stack.

Here is possible approach (tested with Xcode 11.2-13 / iOS 13.2-15)

1) Define environment key to store sheet state

```
struct ShowingSheetKey: EnvironmentKey {
    static let defaultValue: Binding<Bool>? = nil
}

extension EnvironmentValues {
    var showingSheet: Binding<Bool>? {
        get { self[ShowingSheetKey.self] }
        set { self[ShowingSheetKey.self] = newValue }
    }
}
```

2) Set this environment value to root of sheet content, so it will be available in any subview when declared

```
}.sheet(isPresented: $isShowSheet) {
    NavView()
       .environment(\.showingSheet, self.$isShowSheet)
}
```

3) Declare & use environment value only in subview where it is going to be used

```
struct NavSubView: View {
    @Environment(\.showingSheet) var showingSheet

    var body: some View {
        Text("Hello")
        .navigationBarItems(trailing:
            Button("Done") {
                self.showingSheet?.wrappedValue = false
            }
        )
    }
}
```


