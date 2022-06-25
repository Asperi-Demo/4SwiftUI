```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Present a new view in SwiftUI (by CH Wing)

A: **Disclaimer:** Below is not really like a "native modal", neither behave nor look&feel, but if anyone would need a custom transition of one view over other, making active only top one, the following approach might be helpful.

So, if you expect something like the following

![V9uqQ-2](https://user-images.githubusercontent.com/62171579/175772370-1a9da02f-4341-4ec5-b69f-ec77b5a74517.gif)


Here is a simple code for demo the approach (of corse animation & transition parameters can be changed by wish)


    struct ModalView : View {
        @Binding var activeModal: Bool
        var body : some View {
            VStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.activeModal = false
                    }
                }) {
                    Text("Hide modal")
                }
                Text("Modal View")
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.green)
        }
    }
    
    struct MainView : View {
        @Binding var activeModal: Bool
        var body : some View {
            VStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.activeModal = true
                    }
                }) {
                    Text("Show modal")
                }
                Text("Main View")
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.yellow)
        }
    }
    
    struct ModalContainer: View {
        @State var showingModal = false
        var body: some View {
            ZStack {
                MainView(activeModal: $showingModal)
                    .allowsHitTesting(!showingModal)
                    .disabled(showingModal)
                if showingModal {
                    ModalView(activeModal: $showingModal)
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                }
            }
        }
    }

