```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Can I use Binding get set custom binding with @Binding property wrapper? (by Michał Ziobro)

A: Here is possible approach. The demo shows two-directional channel through adapter binding between main & dependent views. Due to many possible callback on update there might be needed to introduce redundancy filtering, but that depends of what is really required and out of scope.

Demo code:

    struct TestBindingIntercept: View {
    
        @State var text = "Demo"
        var body: some View {
            VStack {
                Text("Current: \(text)")
                TextField("", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Divider()
                DependentView(value: $text)
            }
        }
    }
    
    struct DependentView: View {
        @Binding var value: String
    
        private var adapterValue: Binding<String> {
            Binding<String>(get: {
                self.willUpdate()
                return self.value
            }, set: {
                self.value = $0
                self.didModify()
            })
        }
    
        var body: some View {
            VStack {
                Text("In Next: \(adapterValue.wrappedValue)")
                TextField("", text: adapterValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
    
        private func willUpdate() {
            print(">> run before UI update")
        }
    
        private func didModify() {
            print(">> run after local modify")
        }
    }
    
