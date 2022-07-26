```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to stop Divider from expanding vertically in HStack (by Rob N)

A: Here is a demo of possible simplified alternate, without that *artificial* extension. Tested with Xcode 11.4 / iOS 13.4.

![P6LXf](https://user-images.githubusercontent.com/62171579/165102445-d96848d8-4ac8-4a89-8d7a-a0dd983f84f3.png)


    Divider() // or Rectangle().fill(Color.gray).frame(height: 1)
    HStack {
        Button(action: {}) { Text("Cancel").fixedSize() }
            .padding().frame(maxWidth: .infinity)
    
        Divider() // or Rectangle().fill(Color.gray).frame(width: 1)
    
        Button(action: {}) {  Text("Delete").fixedSize() }
            .padding().frame(maxWidth: .infinity)
    
    }.fixedSize(horizontal: false, vertical: true)


Note: It worth also to consider *custom* divider, like

    Rectangle().fill(Color.gray).frame(width: 1) // or any other color

than might give much appropriate visual feedback, like

![KYgTQ](https://user-images.githubusercontent.com/62171579/165102486-c8d6c5d4-4ede-49fe-b617-d3a367dc06ed.png)

