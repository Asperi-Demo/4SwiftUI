```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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
