```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Extra arguments at positions #11, #12 in call SwiftUI (by devmax)

A: ViewBuilder supports only no more than 10 static views in one container... that's a reason of your error

Just group them

```
Group {

    TextField("Class 1-1", text: $class11)
    
    TextField("Class 1-2", text: $class12)
    
    TextField("Class 1-3", text: $class13)
    
    TextField("Class 1-4", text: $class14)
    
    TextField("Class 2-1", text: $class21)
    
    TextField("Class 2-2", text: $class22)
    
    TextField("Class 2-3", text: $class23)
    
    TextField("Class 2-4", text: $class24)

}
```



