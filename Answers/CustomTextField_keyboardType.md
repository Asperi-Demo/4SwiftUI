>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Textfield keyboardType is not working in SwiftUI (by steveSarsawa)

A: SwiftUI standard `.keyboardType` is for SwiftUI standard `TextField`. If you use UIKit `UITextField`, you have to use corresponding UIKit `UIKeyboardType`.

So below is fixed variant (tested with Xcode 11.4 / iOS 13.4) for usage

```
CustomTextField(tag: 1, placeholder: "Phone", 
    strText:self.$txtPhone, keyboardType: .phonePad)
```

![X9X6v](https://user-images.githubusercontent.com/62171579/181903302-e600fe16-07b9-4400-82a1-166c6ab8dcdd.png)


and code

```
struct CustomTextField: UIViewRepresentable {

    var tag:Int = 0
    var placeholder:String?
    @Binding var strText:String
    var keyboardType = UIKeyboardType.default

    class MoveToNextTextField: NSObject, UITextFieldDelegate {
        @Binding var strText: String

        init?(strText: Binding<String>) {
            _strText = strText
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let nextField = textField.superview?.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            return false
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            textField.text = updatedText
            return true
        }
        func textFieldDidChangeSelection(_ textField: UITextField) {
            strText = textField.text ?? ""
        }
    }

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let tmpFeild = UITextField(frame: .zero)
        tmpFeild.tag = tag
        tmpFeild.delegate = context.coordinator
        tmpFeild.placeholder = placeholder
        tmpFeild.keyboardType = keyboardType
        return tmpFeild
    }
    func makeCoordinator() -> CustomTextField.MoveToNextTextField {
        return MoveToNextTextField(strText:$strText)!
    }
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = strText
    }
}
```
