```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Update state of a screen struct from SceneDelegate (by jones)

A: Here is simplest approach

    struct Test: View {
        @State private var isNotificationsEnabled : Bool
    
        private let foregroundPublisher = NotificationCenter.default.publisher(for: UIScene.willEnterForegroundNotification)
    
        var body : some View {
            Toggle(isOn: self.$isNotificationsEnabled) {
                Text("Notifications")
            }
            .onReceive(foregroundPublisher) { notification in
                // do anything needed here
            }
        }
    }

Of course, if your application can have multiple scenes and you need to differentiate them somehow then more complicated variant of this approach will be needed to differentiate which scene generates this notification.
