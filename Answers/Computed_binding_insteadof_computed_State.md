```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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

