```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Can't change the iOS14 widget background color (by Ahmadreza)

A: View does not fill entire widget area - we need to specify full frame, as on below demo

![FlsgD](https://user-images.githubusercontent.com/62171579/163400294-2f40e332-cf02-4ad0-a8aa-aaf261bcc9dc.png)


    StaticConfiguration(
        kind: "xWidget",
        provider: xProvider(),
        placeholder: Text("Loading...")) { entry in
        xWidgetEntryView(entry: entry)
           .frame(maxWidth: .infinity, maxHeight: .infinity)    // << here !!
           .background(Color.green)
    }.supportedFamilies([.systemSmall, .systemMedium, .systemLarge])


