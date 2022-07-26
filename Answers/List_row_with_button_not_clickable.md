```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to make List Item whole row with a button inside not clickable in Swift UI? (by pizzae)

A: List detects active default SwiftUI elements in a row (in this case a button, but NavigationLink handled 
in same way) and tranfer action to entire row by-design. The solution for this is to make it **non-default**
button style, like Plain or your custom

    Button(action: {}) {
        Text("Button")
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .contentShape(Rectangle())
    }
    .buttonStyle(PlainButtonStyle())  // << here !!

See also [this](https://github.com/Asperi-Demo/4SwiftUI/blob/master/Answers/List_row_wide_button.md) answer 
for example of do similar with custom button style
