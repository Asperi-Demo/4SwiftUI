```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: modal presentation works only once from navigationBarItems

A: Well, the issue is in bad layout (seems broken constrains) of navigation bar button after sheet has closed

It is clearly visible in view hierarchy debug:

![mNduH](https://user-images.githubusercontent.com/62171579/164960493-e3268a56-4804-4fb9-9208-da96196919f7.png)

Here is a fix (workaround of course, but safe, because even after issue be fixed it will continue working). 
The idea is not to fight with broken layout but just create another button, so layout engine itself remove 
old-bad button and add new one refreshing layout. The instrument for this is pretty known - use `.id()`

![toimT](https://user-images.githubusercontent.com/62171579/164960505-904ab04f-9acc-4873-b8c7-a9b1a19ae48d.gif)

So modified code:

    struct ContentView: View {
    
        @State var showSheetView = false
        @State private var navigationButtonID = UUID()
        
        var body: some View {
            NavigationView {
                Group {
                    Text("Master")
                    Button(action: { self.showSheetView.toggle() }) {
                        Text("Button 1")
                    }
                }
                .navigationBarTitle("Main")
                .navigationBarItems(trailing: Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Text("Button 2").bold() // recommend .padding(.vertical) here
                }
                .id(self.navigationButtonID)) // force new instance creation
            }
            .sheet(isPresented: $showSheetView) {
                DetailView(isPresented: self.$showSheetView)
                    .onDisappear {
                        // update button id after sheet got closed
                        self.navigationButtonID = UUID()
                    }
            }
        }
    }

