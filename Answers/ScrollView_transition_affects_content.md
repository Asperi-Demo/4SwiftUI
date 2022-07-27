>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Animated transitions and contents within ScrollView in SwiftUI (by Baglan)

A: Here is a solution (updated `body` w/o `GeometryReader`). Tested with Xcode 11.4 / iOS 13.4

![QJaFM](https://user-images.githubusercontent.com/62171579/181212591-0ef7b3eb-92eb-4cca-97a2-14879f5ac39c.gif)

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                // This element "holds" the size
                // while the content is hidden
                Color.clear

                // Content to be toggled
                if self.isShown {
                    ScrollView {
                        Rectangle()
                            .aspectRatio(1, contentMode: .fit)
                    //        .animation(nil)              // << iOS 13 solution !!
                    } // ScrollView
                        .transition(.move(edge: .bottom))
                    //    .animation(.easeOut)             // << iOS 13 solution !!
                }
            } // ZStack
            .animation(.easeOut, value: isShown)           // << iOS 14+ solution !!

            // Button to show / hide the content
            Button(action: {
                self.isShown.toggle()
            }) {
                Text(self.isShown ? "Hide" : "Show")
            }
        } // VStack
    }
