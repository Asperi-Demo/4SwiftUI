```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: remove status bar in SwiftUI - .statusBar(hidden: true) does not work (by devlo)

A: This looks like a SwiftUI bug. The possible valid workaround is to use UIKit view controller, as representable, to manage status bar hidden.

Here is a demo of possible solution. Tested with Xcode 12.4 / iOS 14.4

```
class StatusBarHideHelper: UIViewController {
	override var prefersStatusBarHidden: Bool { true }    // << important !!
}

struct StatusBarHideHelperView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
		StatusBarHideHelper()
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
	}
}
```

and now we can use it in our SwiftUI view hierarchy, like

    var body: some View {
           
        NavigationView {
            VStack {

                NavigationLink(destination: ContentViewC()) {
                    Text("New View")
                }  
            }.offset(y: 100)
            
        }.navigationViewStyle(StackNavigationViewStyle())
        .background(StatusBarHideHelperView())                // << this !!
        .accentColor(.white)
