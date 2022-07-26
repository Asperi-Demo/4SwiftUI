```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Animate a view to slide up and hide on tap in SwiftUI (by TruMan1)

A: Removing view from hierarchy is always animated by container, so to fix your modifier it is needed to apply `.animation` on some helper container (note: `Group` is not actually a *real* container).

![L8fD8](https://user-images.githubusercontent.com/62171579/166983198-fab9c4cc-07e0-42db-ac93-3b6004539d46.gif)

Here is corrected variant

```
struct BannerModifier: ViewModifier {
  @Binding var model: BannerData?
  
  func body(content: Content) -> some View {
    content.overlay(
      VStack {         // << holder container !!
        if model != nil {
          VStack {
            HStack(alignment: .firstTextBaseline) {
              Image(systemName: "exclamationmark.triangle.fill")
              VStack(alignment: .leading) {
                Text(model?.title ?? "")
                  .font(.headline)
                if let message = model?.message {
                  Text(message)
                    .font(.footnote)
                }
              }
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10)
            .shadow(radius: 10)
            Spacer()
          }
          .padding()
          .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
          .onTapGesture {
            withAnimation {
              model = nil
            }
          }
          .gesture(
            DragGesture()
              .onChanged { _ in
                withAnimation {
                  model = nil
                }
              }
          )
        }
      }
      .animation(.easeInOut)     // << here !!
    )
  }
}
```

Tested with Xcode 12.1 / iOS 14.1 and test view:

```
struct TestBannerModifier: View {
  @State var model: BannerData?
  var body: some View {
  VStack {
    Button("Test") { model = BannerData(title: "Error", message: "Fix It!")}
    Button("Reset") { model = nil }
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .modifier(BannerModifier(model: $model))
  }
}
```
