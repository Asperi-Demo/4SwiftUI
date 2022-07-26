```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Display an UIImage in SwitfUI is dark - Apple Watch (by FirsfName Lastname)

A: I suppose it should be 

![EcDqV](https://user-images.githubusercontent.com/62171579/175771180-d80403c3-7bde-428d-b279-1f8a4f9bcb50.png)

    struct ContentView: View {
        var body: some View {
            Image(systemName: "car") // < Native SwiftUI
        }
    }

or... if you so like `UIImage`, the same result with

    Image(uiImage: UIImage(systemName: "car")!).colorInvert()


