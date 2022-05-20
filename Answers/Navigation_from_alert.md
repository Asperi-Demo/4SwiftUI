```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I use Navigation in alert using SwiftUI (by Denzil95)

A: A simplified code snapshot for demo, but think the idea would be clear

    struct TestNavigationFromAlert: View {
    
        @State private var showUnpairAlert: Bool = false
        @State private var activateLink: Bool = false
    
        var body: some View {
            NavigationView {
                VStack {
                    // 1) Invisible navigation link somewhere in main view !!
                    NavigationLink(destination: Text("Your Onboarding page"), isActive: $activateLink,
                        label: { EmptyView() })

                    // DEMO BUTTON - REMOVE IT
                    Button(action: { self.showUnpairAlert = true }) { Text("Alert") }
    
                    // YOUR CODE IS HERE
                }
                .alert(isPresented: $showUnpairAlert) {
                     Alert(title: Text("Unpair from \(checkForDeviceInformation())"), 
                         message: Text("Do you want to unpair the current pod?"), 
                         primaryButton: .destructive(Text("Unpair")) {
                             self.unpairAndSetDefaultDeviceInformation()     // << 2) alert action !!
                         }, 
                         secondaryButton: .cancel())
                 }
            }
        }
    
        func checkForDeviceInformation() -> String {
            // YOUR CODE IS HERE
            return "Stub information"
        }
    
        func unpairAndSetDefaultDeviceInformation() {
            // YOUR CODE IS HERE
            DispatchQueue.main.async {
                self.activateLink = true     // << 3) activated here !!
            }
        }
    }
    
