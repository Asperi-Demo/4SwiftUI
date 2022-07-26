```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: Can't get the transition of a DetailView to a ZStack in the MainView to work (by Wood)

A: Here is a solution. Tested with Xcode 11.4 / iOS 13.4. 

![aTAvq](https://user-images.githubusercontent.com/62171579/177030632-fea66a14-8cf1-4f6c-9470-35c939f0bb7f.gif)

```
struct MainView: View {
    @State var showDetail: Bool = false

    var body: some View {
        ZStack {
            Color.clear // extend ZStack to all area
            VStack {
                Text("Hello MainWorld")
                Button(action: {
                        self.showDetail.toggle()
                }) {
                    Text("Show detail")
                }
            }

            if showDetail {
                DetailView(showDetail: $showDetail)
                    .transition(AnyTransition.move(edge: .bottom))
            }
        }
        .animation(Animation.spring())  // one animation to transitions
        .edgesIgnoringSafeArea(.all)
    }
}

struct DetailView: View {
    @Binding var showDetail: Bool

    var body: some View {
        VStack (spacing: 25) {
            Text("Hello, DetailWorld!")

            Button(action: {
                self.showDetail.toggle()
            }) {
                Text("Close")
            }
            .padding(.bottom, 50)


        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // fill in container
        .background(Color.yellow)
    }
}
```
