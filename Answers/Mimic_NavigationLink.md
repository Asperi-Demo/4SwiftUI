```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How can I mimic the calling signature of NavigationLink (by MarkAurelius)

A: In this case it is just needed to use `Destination` as a simple direct view argument
instead of view builder.

Tested with Xcode 13.3 / iOS 15.4

```
struct SimpleNavLink<Destination, Label>: View where Label : View, Destination : View {

    private let label: () -> Label
    private let destination: Destination   // << here !!

    init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {   // << here !!
        self.label = label
        self.destination = destination
    }

    var body: some View  {
        NavigationLink(destination: destination.headless, label: label)  // << here !!
    }
}
```
