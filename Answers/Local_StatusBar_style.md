```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: Set Status Bar Color For a Specific View (by Scott Crowther)

A: Status bar content color can be modified per view controller based, but SwiftUI uses, most usually, only one view controller, root hosting view controller. So it needs to push that root controller to change `preferredStatusBarStyle` property, which in base class is read-only. 

So the idea is to override default `UIHostingController` to have possibility change that `preferredStatusBarStyle` value and use custom `Environment` value so any internal SwiftUI subview can modify that preferred content style.

Here is approach, scratchy, (it is assumed that target Info.plist is configured appropriately)

    class LocalStatusBarStyle { // style proxy to be stored in Environment
        fileprivate var getter: () -> UIStatusBarStyle = { .default }
        fileprivate var setter: (UIStatusBarStyle) -> Void = {_ in}
    
        var currentStyle: UIStatusBarStyle {
            get { self.getter() }
            set { self.setter(newValue) }
        }
    }
    
    // Custom Environment key, as it is set once, it can be accessed from anywhere
    // of SwiftUI view hierarchy
    struct LocalStatusBarStyleKey: EnvironmentKey { 
        static let defaultValue: LocalStatusBarStyle = LocalStatusBarStyle()
    }
    
    extension EnvironmentValues { // Environment key path variable
        var localStatusBarStyle: LocalStatusBarStyle {
            get {
                return self[LocalStatusBarStyleKey.self]
            }
        }
    }
    
    // Custom hosting controller that update status bar style
    class MyHostingController<Content>: UIHostingController<Content> where Content: View {
        private var internalStyle = UIStatusBarStyle.default
    
        @objc override dynamic open var preferredStatusBarStyle: UIStatusBarStyle {
            get {
                internalStyle
            }
            set {
                internalStyle = newValue
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    
        override init(rootView: Content) {
            super.init(rootView:rootView)
    
            LocalStatusBarStyleKey.defaultValue.getter = { self.preferredStatusBarStyle }
            LocalStatusBarStyleKey.defaultValue.setter = { self.preferredStatusBarStyle = $0 }
        }
    
        @objc required dynamic init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }

Usage..

1) somewhere in scene delegate

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            ...
            window.rootViewController = MyHostingController(rootView: contentView)

2) somewhere in content view

    struct ContentView: View {
        @Environment(\.localStatusBarStyle) var statusBarStyle
    
        ...
        var body: some View {
            ZStack {
               ....
                NavigationView {
                    NavigationLink(destination:  ...) {
                        ...
                    }
                    .onAppear {
                        self.statusBarStyle.currentStyle = .lightContent
                    }
                    .onDisappear {
                         self.statusBarStyle.currentStyle = .default
                     }
                }
            }
        }
    }


