```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI how add custom modifier with callback (by Tim)

A: As possible approach this might look like below - add optional action and in extension provide a
function that injects such action returning copy of self (remaining each view is a value).

As alternate it is possible to use `ViewModifier` protocol with similar result but add several opaque
wrap views.


struct MyComponent: View {
        @Binding var alert: String
        var action: (() -> Void)?       // << here !!

        var body: some View {
            VStack {
                Text("Alert: \(alert)")
                if nil != action {
                    Button(action: action ?? {}) {
                        Text("Action")
                    }
                }
            }
        }
    }

    extension MyComponent {

        func foo(perform action: @escaping () -> Void ) -> Self { // << here !!
             var copy = self
             copy.action = action
             return copy
         }
    }

    struct TestCustomModifier: View {
        @State var message = "state 2"
        var body: some View {
            VStack {
                MyComponent(alert: .constant("state 1"))
                MyComponent(alert: $message).foo {          // << here !!
                    print(">> got action")
                }
            }
        }
    }

    struct TestCustomModifier_Previews: PreviewProvider {
        static var previews: some View {
            TestCustomModifier()
        }
    }

