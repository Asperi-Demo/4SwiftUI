>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Potential SwiftUI ZStack Transition bug when pressed rapidly (by Philip Young)

A: Here is a solution. Tested with Xcode 11.5b

![7jr6b](https://user-images.githubusercontent.com/62171579/182872534-c417ad24-325a-403d-a01b-0f33ecc20a73.gif)

```
struct CView: View {
    @State private var isShown = false
    @State private var showing = false
    var body: some View {
        ZStack {
            Color.white // needed ??
            ZStack {
                Color.green
                VStack {
                    HStack {
                        Spacer()
                        Text("Open").onTapGesture {
                            self.isShown = true
                        }
                    }
                    Spacer()
                }
            }.disabled(showing)        // << inactive on in-progress
//                .edgesIgnoringSafeArea(.all) // ?? bad visibility
            .zIndex(1) // by default it is always 0, so make above white
            if self.isShown {
                ZStack {
                    Color.red
                    VStack {
                        HStack {
                            Spacer()
                            Text("Close").onTapGesture {
                                self.isShown = false
                            }
                        }
                        Spacer()
                    }
                }
                .transition(AnyTransition.move(edge: .bottom))
                .animation(.easeInOut)
//                .edgesIgnoringSafeArea(.all)      // ??
                .zIndex(2)       // top-most
                .onAppear {
                    self.showing = true
                }
                .onDisappear {
                    self.showing = false
                }
            }
        }
    }
}
```
