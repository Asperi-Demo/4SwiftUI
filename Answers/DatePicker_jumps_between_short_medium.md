```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI DatePicker jumps between short and medium date formats when changing the date (by dr_barto)

A: Looks like a bug. Here is a found workaround (tested with Xcode 13beta / iOS 15)

![JXZhm](https://user-images.githubusercontent.com/62171579/163764357-55d55a49-f7d6-4983-8860-9b4b4904061a.gif)


      DatePicker(
        "Date",
        selection: $date,
        displayedComponents: .date
      )
      .labelsHidden()
      .id(date)             // << here !!

