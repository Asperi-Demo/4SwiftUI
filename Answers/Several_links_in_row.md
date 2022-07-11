```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to have a NavigationLink inside another NavigationLink (by amodrono)

A: Here is a demo of possible solution on some replicated scenario (because provided code is not testable as-is). The idea is to reuse one NavigationLink but with different destinations depending on activation place.

Tested with Xcode 12 / iOS 14


```
struct DemoRowView: View {
    @State private var isProfile = false
    @State private var isActive = false
    var body: some View {
        HStack {
            Image(systemName: "person")
                .scaledToFit()
                .onTapGesture {
                    self.isProfile = true
                    self.isActive = true
                }
            Text("Thread description")
                .onTapGesture {
                    self.isProfile = false
                    self.isActive = true
                }
                .background(
                    NavigationLink(destination: self.destination(), isActive: $isActive) { EmptyView() }
                )
        }
        .buttonStyle(PlainButtonStyle())
    }

    @ViewBuilder
    private func destination() -> some View {
        if isProfile {
            ProfileView()
        } else {
            ThreadView()
        }
    }
}
```
