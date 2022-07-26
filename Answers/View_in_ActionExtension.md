```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Initiate with SwiftUI content view instead of ActionViewController in iOS Action Extention (by Priyam Dutta)

A: Your principal class can look like the following (tested & worked with Xcode 11.2)

    class ActionViewController: UIHostingController<AnyView> {
    
        // override designated initialiser
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            let contentView = ActionExtensionInitialView() // << SwiftUI root view
            super.init(rootView: AnyView(contentView))
        }
    
        @objc required dynamic init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillAppear(_ animated: Bool) {
			      super.viewWillAppear(animated)
			      // take URL from extension here
		    }
    }

