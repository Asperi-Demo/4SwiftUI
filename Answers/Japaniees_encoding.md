```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to specify Japanese encoding for a UILabel? (by BlueRaja - Danny Pflughoeft)

![L2MMT](https://user-images.githubusercontent.com/62171579/174340822-dbb634ec-6521-4be6-9f39-7189baec6894.png)

A: You just need to specify language identifier for attributed string, like

    let label = UILabel()
    let text = NSAttributedString(string: "直", attributes: [
    	.languageIdentifier: "ja",                            // << this !! 
     	.font: UIFont.systemFont(ofSize: 64)
    ])
	label.attributedText = text

![wTR2j](https://user-images.githubusercontent.com/62171579/174340885-9d882cb9-c006-4dd1-b2a0-18ae0fd9bd46.png)

Tested with Xcode 13.2 / iOS 15.2

