>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to display a fullstack modal with SwiftUI? (by marcgg)

A: Here is a demo of possible solution.

![UjFp4](https://user-images.githubusercontent.com/62171579/182540987-7256496e-6203-4052-ac2f-f9da7f54cbbf.gif)

```
struct DemoModalOverTabView: View {
    @State private var showModally = false
    var body: some View {
        ZStack {
            TabView {     //  << main tab view
                DemoTab
            }.disabled(showModally) // << deactivate forcefully

            if showModally {
                DemoModal     //  << modal view
                   .zIndex(1)     // << required !!
                   .transition(.move(edge: .bottom)).animation(.default)
            }
        }
    }

    var DemoTab: some View {
        Button("Show") { self.showModally = true }
            .tabItem { Image(systemName: "person") }
    }

    var DemoModal: some View {
        Button("Hide") { self.showModally = false }
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .background(Color.yellow)
           .edgesIgnoringSafeArea(.all)
    }
}
```
