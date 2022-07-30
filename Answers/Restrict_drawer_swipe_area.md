>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Swipe back gesture like in without navigationView in SwiftUI (by Anthney)

A: Here is possible solution - the idea is to attach gesture to overlay that is as wide at the left as needed. Tested with Xcode 12 / iOS 14

*Note: on demo the active area made `Color.blue` instead of `Color.clear` for better visibility*

![osRFH](https://user-images.githubusercontent.com/62171579/181903479-25f5ca1f-7207-4df1-8363-6ed83f9282da.gif)

```
struct SwipingView : View {
  @State private var dragAmount = CGSize.zero
  @GestureState private var position = CGSize.zero
  func addToPosition(translation:CGSize) -> CGSize {
    return CGSize(width: dragAmount.width + translation.width, height: dragAmount.height + translation.height)
  }

  var body: some View{
    return ZStack(){
      Rectangle().fill(Color.red).frame(width: 100, height:400).scaleEffect(x:5,y:1,anchor: .leading)
        .overlay(Color.clear.frame(width: 40)       // << make width as needed
        .contentShape(Rectangle())
        .gesture(
          DragGesture(minimumDistance: 20)
            .updating(self.$position){ value, state, translation in
              state = value.translation
            }
            .onEnded{ value in
              if value.translation.width > 50 {
                guard position.width + self.addToPosition(translation: CGSize(width:330, height:0)).width < 330-1 else {
                  return print("too far right")
                }
                self.dragAmount = self.addToPosition(translation: CGSize(width:330, height:0))
              } else {
                guard position.width + self.addToPosition(translation: CGSize(width:-330, height:0)).width > -330-1 else {
                  return print("too far left")
                }
                self.dragAmount = self.addToPosition(translation: CGSize(width:-330, height:0))
              }
            }
        ), alignment: .leading)
        .offset(x: 190)
        .offset(x: addToPosition(translation: position).width )
    }.animation(Animation.linear)
  }
}
```
