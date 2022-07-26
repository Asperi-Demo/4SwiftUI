```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - Animate transition (by squarehippo10)

A: Here is a simplified demo on a replicated onboarding code (and I made some longer delay to make it mode visible). 
Of course it is possible to tune it for the needs by changing type of transition or animation, etc. 

Tested with Xcode 12 / iOS 14

![ZhyAy](https://user-images.githubusercontent.com/62171579/180609937-9fc432b5-3a36-45eb-bb11-1cf56f2bddc8.gif)

```
class Tower: ObservableObject {
    enum PageType {
        case onboarding, login, idle
    }
    @Published var currentPage: PageType = .onboarding
}

struct ConductorView: View {
   @EnvironmentObject var tower: Tower
   let onboardingCompleted = false

   var body: some View {
      VStack {
         if tower.currentPage == .onboarding {
            Onboarding1View()
         } else if tower.currentPage == .login {
            Text("LoginView")
                .transition(.move(edge: .trailing))    // << here !!
         } else if tower.currentPage == .idle {
            Text("IdleView")
         }
      }
      .animation(.default, value: tower.currentPage)   // << here !!
      .onAppear{
         if self.onboardingCompleted {
            self.tower.currentPage = .login
         } else {
            self.tower.currentPage = .onboarding
         }
      }
   }
}


struct Onboarding1View: View {
   @EnvironmentObject var tower: Tower
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented = true
    var body: some View {
        Text("Login")
            .sheet(isPresented: $isPresented) {
                Button(action: {
                   self.presentationMode.wrappedValue.dismiss()
                   DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                      self.tower.currentPage = .login
                   }
                }) {
                   Text("Sign Out")
                }
            }
    }
}
```
