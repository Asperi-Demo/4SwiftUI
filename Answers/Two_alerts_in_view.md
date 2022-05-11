```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to consecutively present two alert views using SwiftUI (by DaWei Xu)

A: It appears (tested with Xcode 11.2):

 1. While not documented, but it is not allowed to add more than one
    .alert modifier in one view builder sequence - works only latest 
 2. It is not allowed to add .alert modifier to EmptyView, it does not work
    at all

I've found alternate solution to proposed by @Rohit. In some situations, many alerts, this might result in simpler code.


    struct TestTwoAlerts: View {
        @State var alertIsVisible = false
        @State var bonusAlertIsVisible = false
    
        var score = 100
        var title = "First alert"
    
        var body: some View {
            VStack {
                Button(action: {
                     self.alertIsVisible = true
                }) {
                     Text("Hit Me!")
                }
                .alert(isPresented: $alertIsVisible) {
                    Alert(title: Text("\(title)"), message: Text("\n"), dismissButton:.default(Text("Next Round"), action: {
                        if self.score == 100 {
                            DispatchQueue.main.async { // !! This part important !!
                                self.bonusAlertIsVisible = true
                            }
                        }
                    }))
                }
                Text("")
                .alert(isPresented: $bonusAlertIsVisible) {
                        Alert(title: Text("Bonus"), message: Text("You've earned 100 points bonus!!"), dismissButton: .default(Text("Close")))
                }
            }
        }
    }
    
    
