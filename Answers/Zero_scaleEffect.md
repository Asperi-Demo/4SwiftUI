```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI : [Unknown process name] CGAffineTransformInvert: singular matrix ERROR (by Aryan)

A: The problem is in `0` scaleEffect - zero is not hanlable so we need to use some tiny small number instead.

Here is fixed code. Tested with Xcode 11.4 / iOS 13.4. Also corrected animation for the case of `isLoading = false`

![awdBn](https://user-images.githubusercontent.com/62171579/180480295-dcd954d9-7353-4811-aeb5-3dfaf90f1410.gif)

```
struct ContentView: View {
    @State private var count=0
    @State var isPressed = false
    @State var pressed = false
    @State var isLoading = false
    var body: some View {

        VStack {
            ZStack{
                Circle()
                    .fill( isPressed ? Color(.systemGray4) : .red )
                    .overlay(Image(systemName:"heart.fill")
                        .foregroundColor(isPressed ? .red :.white)
                        .font(.system(size:100))

                        .scaleEffect( pressed ? 1.5 : 1.0)
                )
                .frame(width: 300, height: 300)
            }
            .onTapGesture{
                self.isLoading.toggle()
                withAnimation(.spring(response: 1,dampingFraction: 0.4, blendDuration :0.9)){
                    self.isPressed.toggle()
                    self.pressed.toggle()
                }
            }

            HStack{
                ForEach(0...4, id: \.self){index in
                    Circle()
                        .frame(width:10,height:10)
                        .foregroundColor(.green)
                        .scaleEffect(self.isLoading ? 1: 0.01)     // << here !!
                        .animation(self.isLoading ? Animation.linear(duration:0.6).repeatForever().delay(0.2*Double(index)) :
                            .default
                        )
                }
            }
            .padding()
        }
    }
}
```
