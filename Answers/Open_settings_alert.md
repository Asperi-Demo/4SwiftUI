```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Is there an equivalent of openSettingsURLString in SwiftUI? (by Alexis Wei)

A: Here it is

```
.alert(isPresented: $alertVisible) {
     Alert (title: Text("Camera access required to take photos"),
            message: Text("Go to Settings?"),
            primaryButton: .default(Text("Settings"), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }),
            secondaryButton: .default(Text("Cancel")))
        }

```
