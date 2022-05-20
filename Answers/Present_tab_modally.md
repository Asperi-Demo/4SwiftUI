```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI Present View Modally via TabView? (by Steven Schafer)

A: Here is a possible approach, based on idea of using thing wrapper view which will present target 
view as a sheet...

Here it goes:

    struct SheetPresenter<Content>: View where Content: View {
        @Binding var presentingSheet: Bool
        var content: Content
        var body: some View {
            Text("")
                .sheet(isPresented: self.$presentingSheet, content: { self.content })
                .onAppear {
                    DispatchQueue.main.async {
                        self.presentingSheet = true
                    }
                }
        }
    }

and usage for your case is...

    // New Listing
        SheetPresenter(presentingSheet: $newListingPresented, content: NewListingView())
        .tabItem {
            VStack {
                Image(systemName: (selection == 1 ? "plus.square.fill" : "plus.square"))
            }
        }
        .tag(1)

If you will need to to change tab `selection` after work in sheet you could pass some additional argument in `SheetPresenter` and use it in sheet's `onDismiss: (() -> Void)?` callback.
