```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How do you perform work aside from just pushing the new view when using NavigationLink? (by ajf1000)

A: Here is the simplest way - react on appear of destination

    NavigationView {
         NavigationLink("Click Here", destination: 
             AnotherView()
                 .onAppear {
                     // any action having access to current view context
                 })
    }

Retested with Xcode 13.3
