```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to push a new root view using SwiftUI without NavigationLink? (by user1865027)

A: Here is possible alternate approach of how to replace root view completely... using notifications

    class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
        let loginRootViewNotification = 
             NSNotification.Name("loginRootViewNotification") // declare notification
        private var observer: Any?               // ... and observer
    
    
        ...
        // in place of window creation ...
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
    
            observer = NotificationCenter.default.addObserver(forName: loginRootViewNotification, object: nil, queue: nil, using: { _ in
                let anotherRootView = AnotherRootView() 
                // create another view on notification and replace
                window.rootViewController = UIHostingController(rootView: anotherRootView)
            })


in your desired place post needed notification

    Button(action: { 
    // launch new root view here 
       NotificationCenter.default.post(loginRootViewNotification)
    }, label: {Text("Login")}).padding()

