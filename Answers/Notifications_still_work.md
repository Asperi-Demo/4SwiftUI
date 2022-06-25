```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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
