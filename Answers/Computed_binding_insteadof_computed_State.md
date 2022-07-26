```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Create a computed @State variable in SwiftUI (by Senseful)

A: Here is an approach I prefer with computed property & binding "on-the-fly"

    private var bindableIsVisibleError: Binding<Bool> { Binding (
        get: { self.model.usernameResult.isVisibleError },
        set: { if !$0 { self.model.dismissUsernameResultError() } }
        )
    }

and usage (as specified)

    Toggle(isOn: bindableIsVisibleError, label: { EmptyView() })

