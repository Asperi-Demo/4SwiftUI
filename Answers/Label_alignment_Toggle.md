```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: how to change text alignment of label in Toggle? (by mallow)

A: Here it is - use explicit frame alignment:

![4bijP](https://user-images.githubusercontent.com/62171579/167362497-6ae58c74-54b9-4018-aad2-a2282e1f0e8d.png)

    Toggle(isOn: $vibrateOnRing) {
        Text("Vibrate on Ring")
          .frame(maxWidth: .infinity, alignment: .trailing)
    }

