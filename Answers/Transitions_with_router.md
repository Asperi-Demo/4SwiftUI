```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Transitions not working with a router in SwiftUI (by Elvin)

A: Add animation to parent container

```
var body: some View {
    VStack {
        if authRouter.viewName == AuthViews.Onboarding {
            Onboarding()
        } else if authRouter.viewName == AuthViews.SignIn {
            SignIn()
                .transition(.scale)
        } else if authRouter.viewName == AuthViews.SignUp {
            SignUp()
                .transition(.move(edge: .trailing))
        } else if authRouter.viewName == AuthViews.ForgotPassword {
            ForgotPassword()
                .transition(.move(edge: .trailing))
        }
    }.animation(.default)     // << here !! (any animation you like)
}
```

and make sure that `authRouter.viewName` is always updated on `DispatchQueue.main`.
