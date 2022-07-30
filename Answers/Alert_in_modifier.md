>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Inform view that alert OK button is clicked in swiftUI (by Sona)

A: Here is a demo of solution with passed callback into modifier. Tested with Xcode 11.4 / iOS 13.4.

![BAHDq](https://user-images.githubusercontent.com/62171579/181906694-c8b1e5d0-b302-4c7f-a370-bf21841d5d37.gif)

```
struct ShowAlert: ViewModifier {

    @Binding var showingAlert: Bool
    let title: String
    let message: String
    var callback: () -> () = {}    // << here !!

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $showingAlert) { () -> Alert in
                Alert(title: Text(title), message: Text(message),
                    primaryButton: .default (Text("OK")) {
                      print("OK button tapped")
                      self.callback()             // << here !!
                },secondaryButton: .cancel())
        }
    }
}

// Demo view
struct TestAlertModifier: View {
    @State private var showAlert = false
    @State private var demoLog = "Wait for alert..."
    var body: some View {
        NavigationView {
            ScrollView {
                    Text(demoLog)
                }.navigationBarTitle("Click")
                .navigationBarItems(trailing: Button(action: {
                    self.showAlert = true
                }) {
                    Image(systemName: "lock")
                }.modifier(ShowAlert(showingAlert: $showAlert, title: "",
                                 message: "Are you sure you want to Logout", callback: confirmAlert)))
        }
    }

    private func confirmAlert() {
        self.demoLog = "Tapped - OK"
    }
}
```
