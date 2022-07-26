```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to set a custom environment key in SwiftUI? (by Sid)

A: The `Environment` is used to pass values in `parent > child` direction, so value is set for usage. If you want to change *internal* of environment value then you need to wrap it somehow, possible variants are binding or reference type holder.

Here is an example of usage based on binding (similar to how .editMode and .presentationMode work)

```
struct TestResetEnv: View {
    @State private var isActive = false
    @State private var reset = false
    var body: some View {
        VStack {
            Text("Current: \(reset ? "true" : "false")")
            Button("Go") { self.isActive.toggle() }
            if isActive {
                ResetView()
            }
        }.environment(\.resetDefault, $reset) // set for children as env!!
    }
}

struct ResetDefault: EnvironmentKey {
    static var defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var resetDefault: Binding<Bool> {
        get { self[ResetDefault.self] }
        set { self[ResetDefault.self] = newValue }
    }
}

struct ResetView: View {
    @Environment(\.resetDefault) var reset
    var body: some View {
        Text("Reset").onAppear() {
            self.reset.wrappedValue.toggle() // << change wrapped !!
        }
    }
}
```
