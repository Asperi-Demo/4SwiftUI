```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to change icon color in UIAction inside UIMenu? (by X.Creates)

A: You need to use rendering mode `.alwaysOriginal` because internally they 
use `UIImageView`, which applies own `tintColor` for all template image.

So making

    func contextMenuActions() -> [UIMenuElement] {
        let imageView = UIImage(systemName: "eye")?.withTintColor(.red, 
              renderingMode: .alwaysOriginal)                            // << here !!

gives

![vZzBp](https://user-images.githubusercontent.com/62171579/165684987-6607502e-a284-418c-93b4-99ec0fe109c0.png)

Tested with Xcode 12.1

