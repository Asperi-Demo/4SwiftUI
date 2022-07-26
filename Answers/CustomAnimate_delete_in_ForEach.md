```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Add animations to ForEach loop elements (SwiftUI) (by Nguyễn Khắc Hào)

A: It looks like this problem is still up to day (Xcode 11.4), because by just copy-pasting the observed effect is the same. So, there are a couple of problems here: first, it needs to setup combination of animation and transition correctly; and, second, the `ForEach` container have to know which exactly item is removed, so items must be identified, instead of indices, which are anonymous.

As a result we have the following effect (transition/animation can be others):

![gbZS1](https://user-images.githubusercontent.com/62171579/170279163-c59cf1f1-6b6e-4e45-883c-6efead7e1f34.gif)

```swift
struct TestAnimationInStack: View {
    @State var ContentArray = ["A","B","C", "D", "E", "F", "G", "I", "J"]
    var body: some View {
        ScrollView{
        VStack{
            ForEach(Array(ContentArray.enumerated()), id: \.element){ (i, item) in // << 1) !
                ZStack{
                // Object
                    Text(item)
                    .frame(width:100,height:100)
                    .background(Color.gray)
                    .cornerRadius(20)
                    .padding()
                //Delete button
                    Button(action: {
                       withAnimation { () -> () in              // << 2) !!
                           self.ContentArray.remove(at: i)         
                       }
                    }){
                    Text("✕")
                    .foregroundColor(.white)
                    .frame(width:40,height:40)
                    .background(Color.red)
                    .cornerRadius(100)
                   }.offset(x:40,y:-40)
                }.transition(AnyTransition.scale)              // << 3) !!!
           }
         }
       }
   }
}
```
