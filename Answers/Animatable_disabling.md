```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Can the changes of the ".disabled" modifier of SwiftUI be animated? (by backslash-f)

A: The possible solution can be to combine with `.colorMultipy`, of course the *disabled* color should be experimentally fit, but this gives common effect animatable

![3zP28](https://user-images.githubusercontent.com/62171579/180761523-93c38343-ea6c-464b-b348-d6f749754f33.gif)

```
.disabled(isDisabled)
.colorMultiply(isDisabled ?  // 👈🏻 animatable
      Color.gray /* to be selected to fit*/ : .white)
.animation(.default, value: isDisabled)
```
