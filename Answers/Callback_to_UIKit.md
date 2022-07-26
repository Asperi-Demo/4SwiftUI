```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Callback with passing data from SwiftUI to UIKit (by Degtiarev Aleksei)

A: You can pass it via argument, like

```
struct MyView: View {
    var buttonPressed: ((String) -> Void)? // << here !!
    @State var someData = ""
    
    var body: some View {
        ZStack {
            Color.purple
            Button(action: {
                someData = "new Data"
                self.buttonPressed?(someData)  // << here !!
```

and 

        hostingViewController.rootView.buttonPressed = { value in // << here !!
            print("callback received")
            print(value)
        }
