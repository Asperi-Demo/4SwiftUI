```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - Pop back in navigation stack does not deallocate a view (by Matrosov Oleksandr)

A: Actually it is not clear if it is defect or not - SwiftUI views are values, so there is no *dealloc* thing for them. It looks like `NavigationView` just keeps something like *lastView* variable until it is replaced with another one. Maybe worth submitting feedback to Apple.

Meanwhile here is solution that allows to defer real destination view creation until exactly `NavigationLink` tapped and cleanup it (w/ any related resources, like view model) when view is removed from stack by Back button.

Tested with Xcode 11.4 / iOS 13.4

Helper proxy view presenter:

```
struct LinkPresenter<Content: View>: View {
    let content: () -> Content

    @State private var invlidated = false
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        Group {
            if self.invlidated {
                EmptyView()
            } else {
                content()
            }
        }
        .onDisappear { self.invlidated = true }
    }
}
```

Usage: 

```
NavigationLink(destination: LinkPresenter { WelcomeView() }, 
    isActive: $showWelcomeView) { EmptyView() }
```
