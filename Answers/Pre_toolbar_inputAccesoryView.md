```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI inputAccesoryView Implementation (by James Woodcock)

A: Here is a demo with custom toolbar & binding for entered text, but simplified by 
excluding on dismiss callback (as it is not important for approach demo), just to 
have less code. Hope it will be helpful.

    import SwiftUI
    import UIKit
    import Combine
    
    struct CustomInputTextField : UIViewRepresentable {
        
        @Binding var text: String
        
        let textField = UITextField(frame: CGRect(x:0, y:0, width: 100, height: 32)) // just any
    
        func makeUIView(context: UIViewRepresentableContext<CustomInputTextField>) -> UITextField {
            return textField
        }
        
        func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomInputTextField>) {
            self.textField.text = text
        }
        
        func makeCoordinator() -> CustomInputTextField.Coordinator {
            let coordinator = Coordinator(self)
    
            // configure a toolbar with a Done button
            let toolbar = UIToolbar()
            toolbar.setItems([
                // just moves the Done item to the right
                UIBarButtonItem(
                    barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace
                    , target: nil
                    , action: nil
                )
                , UIBarButtonItem(
                    title: "Done"
                    , style: UIBarButtonItem.Style.done
                    , target: coordinator
                    , action: #selector(coordinator.onSet)
                )
                ]
                , animated: true
            )
            toolbar.barStyle = UIBarStyle.default
            toolbar.sizeToFit()
    
            textField.inputAccessoryView = toolbar
            return coordinator
        }
    
        typealias UIViewType = UITextField
        
        class Coordinator: NSObject {
            let owner: CustomInputTextField
            private var subscriber: AnyCancellable
            
            init(_ owner: CustomInputTextField) {
                self.owner = owner
                subscriber = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: owner.textField)
                    .sink(receiveValue: { _ in
                        owner.$text.wrappedValue = owner.textField.text ?? ""
                    })
            }
    
            @objc fileprivate func onSet() {
                owner.textField.resignFirstResponder()
            }
            
        }
    }
    
    struct DemoCustomKeyboardInput : View {
        
        @State var email:String = ""
        
        var body: some View {
            VStack{
                CustomInputTextField(text: $email).border(Color.black)
                    .padding(.horizontal)
                    .frame(maxHeight: 32)
                Divider()
                Text("Entered text: \(email)")
            }
        }
    }
    
    struct DemoCustomKeyboardInput_Previews: PreviewProvider {
        static var previews: some View {
            DemoCustomKeyboardInput()
        }
    }

