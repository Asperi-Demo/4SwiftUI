```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Swift: How to activate and unhide window of ANY application? (by Andrew____Pls_Support_Ukraine)

A: Here is working Playground module. The approach is to use KVO for observable properties to be informed when exactly desired state for target application occurs. Hope it would be helpful somehow.

    import Cocoa
    
    class AppActivator: NSObject {
    
        private var application: NSRunningApplication!
        private let filterName: String
    
        init(appName: String) {
            filterName = appName
        }
        
        func activate() {
            guard let app = NSWorkspace.shared.runningApplications.filter ({
                return $0.localizedName == self.filterName || $0.bundleIdentifier?.contains(self.filterName) ?? false
            }).first else {
                print("Application \(self.filterName) not found")
                return
            }
    
            guard app.activationPolicy != .prohibited else {
                print("Application \(self.filterName) prohibits activation")
                return
            }
    
            self.application = app
            
            self.unhideAppIfNeeded()
            self.activateAppIfNeeded()
        }
        
        private func unhideAppIfNeeded() {
            if application.isHidden {
                application.addObserver(self, forKeyPath: "isHidden", options: .new, context: nil)
                application.unhide()
            }
        }
        
        private func activateAppIfNeeded() {
            if !application.isHidden && !application.isActive {
                application.addObserver(self, forKeyPath: "isActive", options: .new, context: nil)
                application.activate(options: .activateIgnoringOtherApps)
            }
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "isHidden" {
                application.removeObserver(self, forKeyPath: "isHidden")
                activateAppIfNeeded()
            } else if keyPath == "isActive" {
                application.removeObserver(self, forKeyPath: "isActive")
                print("Application \(application.localizedName) - ACTIVATED!")
            }
        }
    }
    
    let activator = AppActivator(appName: "Finder")
    activator.activate()

