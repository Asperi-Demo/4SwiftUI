```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Programaticly dismiss popover in SwifUI (by mica)

A: It is not clear from question in which environment and what exactly *strange* happens, because as tested the provided code works well with Xcode 11.2/3+ and iOS13.2+.

Anyway there is alternate approach to close popovers using `\.presentationMode` as below

**Update:** Well, I've found that original question probably concerns about `macOS`, because provided on macOS popover is not closed with described scenario.

Here is a variant of usage for both iOS/macOS platforms (tested & works with Xcode 11.3 / macOS 10.15)


    struct Pop: View {
        @Binding var showSheet: Bool
        //@Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            VStack {
                Text("Option 1")
                Text("Option 2")
                Button("Cancel")
                {
                    #if os(OSX)
                    NSApp.sendAction(#selector(NSPopover.performClose(_:)), to: nil, from: nil)
                    #else
                    //self.presentationMode.wrappedValue.dismiss() // << behaves the same as below
                    self.showSheet = false
                    #endif
                }
            }
        }
    }

