>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Is there a way to animate navigationbaritems with withAnimation(...? (by NilsBerni)

A: A possible solution is to separate that state dependent animatable code into standalone view, like show below.

Retested with Xcode 13.4 / iOS 15.5<br>
Tested with Xcode 12.4 / iOS 14.4

![rnTNq](https://user-images.githubusercontent.com/62171579/183258287-e029001c-18e5-4bc1-9c71-cfc47f068083.gif)

```
struct TestBarAnimationView: View {

      @State var red = true

      var body: some View {
        NavigationView {
            VStack {
                RectView(red: $red)       // << here !!
                Spacer()
            }
            .navigationTitle("Test")
            .navigationBarItems(leading:
                RectView(red: $red)       // << here !!
            )
        }

       }
    }


struct RectView: View {
  @Binding var red: Bool

  var body: some View {
    HStack {
       Rectangle()
          .fill(red ? Color.red : .blue)
          .onTapGesture {
          withAnimation(Animation.easeIn(duration: 1), {
            red.toggle()
            })
          }
    }
  }
}
```
