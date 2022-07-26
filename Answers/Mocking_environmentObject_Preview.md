```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - Mocking @EnvironmentObject data in preview (by Matrosov Oleksandr)

A: Assuming the `UserService` has correctly designed using dependency injection, it can be used the following approach with any explicit changes in production code

```
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        let userService = UserService()
        userService.user = User(username: "Alex", email: "alex@test.com") // << any predefined set up here
        // any more parameters set up here

        return WelcomeView().environmentObject(userService)
    }
}
```
