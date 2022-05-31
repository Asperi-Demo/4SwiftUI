```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI: UIAlertController's textField does not responding in UIAlertAction (by Nasir)

A: Here is full demo module for solution that works. Tested with Xcode 11.4 / iOS 13.4

![nrJW8](https://user-images.githubusercontent.com/62171579/171160841-b354dd53-cdac-488c-ad56-3c2b00da3277.gif)

See also important comments inline

```
struct AlertControl: UIViewControllerRepresentable {

    @Binding var textString: String
    @Binding var show: Bool

    var title: String
    var message: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertControl>) -> UIViewController {
        return UIViewController() // holder controller - required to present alert
    }

    func updateUIViewController(_ viewController: UIViewController, context: UIViewControllerRepresentableContext<AlertControl>) {
        guard context.coordinator.alert == nil else { return }
        if self.show {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            context.coordinator.alert = alert

            alert.addTextField { textField in
                textField.placeholder = "Enter some text"
                textField.text = self.textString            // << initial value if any
                textField.delegate = context.coordinator    // << use coordinator as delegate
            }
            alert.addAction(UIAlertAction(title: "cancel", style: .destructive) { _ in
                // your action here
            })
            alert.addAction(UIAlertAction(title: "Submit", style: .default) { _ in
                // your action here
            })

            DispatchQueue.main.async { // must be async !!
                viewController.present(alert, animated: true, completion: {
                    self.show = false  // hide holder after alert dismiss
                    context.coordinator.alert = nil
                })
            }
        }
    }

    func makeCoordinator() -> AlertControl.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var alert: UIAlertController?
        var control: AlertControl
        init(_ control: AlertControl) {
            self.control = control
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text as NSString? {
                self.control.textString = text.replacingCharacters(in: range, with: string)
            } else {
                self.control.textString = ""
            }
            return true
        }
    }
}

// Demo view for Alert Controll
struct DemoAlertControl: View {
    @State private var text = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
            Button("Alert") { self.showAlert = true }
                .background(AlertControl(textString: self.$text, show: self.$showAlert,
                         title: "Title goes here", message: "Message goes here"))
            Text(self.text)
        }
    }
}
```
