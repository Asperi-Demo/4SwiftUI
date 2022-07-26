```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: ToolbarItem(placement: .navigationBarTrailing) positions icon to trailing edge of parent view (by bobby123uk)

<img width="221" alt="zi8Bn" src="https://user-images.githubusercontent.com/62171579/178134086-81225f0b-3342-4747-888d-4e6dc45305c6.png">

A: This is how default button style works. It can be turned off by using plain style and then you can design it as you want (in-place or wrap into own style)

Tested with Xcode 13.3 / iOS 15.4

![jWerj](https://user-images.githubusercontent.com/62171579/178134078-9a03fd09-6bca-410f-8fd1-1208a75ba0f7.png)

```
ToolbarItem(placement: .navigationBarTrailing) {
    Button {
        // action
    } label: {
        Image(systemName: "keyboard")
        	.foregroundColor(.blue).padding(4)     // << here !!
    }
    .buttonStyle(PlainButtonStyle()) // turn off design, only behavior 
    .border(.red, width: 1)
}
```
