```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to remove Observer in swiftUI? (by Abid Nawaz)

A: Here is SwiftUI approach to observe notifications

```
struct MainListView: View {

    let redrawCategoriesPublisher = NotificationCenter.default.publisher(for: 
          Notification.Name(rawValue: "redrawCategories"))

    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            Text("Demo")
        }
        .onReceive(redrawCategoriesPublisher) { notification in
            // do here what is needed
        }
    }
}
```
