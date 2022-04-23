```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Use Binding<Int> with a TextField SwiftUI (by Bernard)

A: Of course it is possible to use

    TextField("", value: $value, formatter: NumberFormatter())
    //    .keyboardType(UIKeyboardType.decimalPad) // << uncomment for num pad

and even with Numeric Pad, but this does not prevent to enter non-numeric characters into such `TextField`, and until commit `formatter` is not called to validate input. Maybe Apple will give us possibility to validate input on the fly in future, but not now, ... so I prefer different way

Here is my approach to have text field for numeric values (Int, Float, Double, etc.) which validates input and limits of specific type (say do not allow to enter values longer then fit into Int maximum allowed value). Hope it would be helpful for someone as well. (Of course configurations like font, size, colors, etc. are possible per usage needs)


    struct NumberTextField<V>: UIViewRepresentable where V: Numeric & LosslessStringConvertible {
        @Binding var value: V
        
        typealias UIViewType = UITextField
    
        func makeUIView(context: UIViewRepresentableContext<NumberTextField>) -> UITextField {
            let editField = UITextField()
            editField.delegate = context.coordinator
            return editField
        }
        
        func updateUIView(_ editField: UITextField, context: UIViewRepresentableContext<NumberTextField>) {
            editField.text = String(value)
        }
        
        func makeCoordinator() -> NumberTextField.Coordinator {
            Coordinator(value: $value)
        }
    
        class Coordinator: NSObject, UITextFieldDelegate {
            var value: Binding<V>
            
            init(value: Binding<V>) {
                self.value = value
            }
            
            func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                           replacementString string: String) -> Bool {
                
                let text = textField.text as NSString?
                let newValue = text?.replacingCharacters(in: range, with: string)
                
                if let number = V(newValue ?? "0") {
                    self.value.wrappedValue = number
                    return true
                } else {
                    if nil == newValue || newValue!.isEmpty {
                        self.value.wrappedValue = 0
                    }
                    return false
                }
            }
            
            func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
                if reason == .committed {
                    textField.resignFirstResponder()
                }
            }
        }
    }
    
    struct TestTextFieldWithNumbers: View {
        @State private var value = 0
        var body: some View {
            VStack {
                Text("Current value: \(value)")
                Divider()
                TextField("", value: $value, formatter: NumberFormatter())
    //                .keyboardType(UIKeyboardType.decimalPad)
                Divider()
                NumberTextField(value: $value)
                    .frame(height: 32)
            }
        }
    }
    
    struct TestTextFieldWithNumbers_Previews: PreviewProvider {
        static var previews: some View {
            TestTextFieldWithNumbers()
        }
    }

