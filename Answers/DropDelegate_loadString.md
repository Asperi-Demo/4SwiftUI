```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: Not getting dropped NSString value in DropDelegate (by iphaaw)

A: I don't recall where (somewhere in depth of Apple's docs) but I met occasionally that we should not use base UTTypes (like public.text) for data loading - instead only concrete types (like in this answer) must be used.

The `NSString` register itself as UTF-8 plain text type provider (it conforms to public.text but cannot be decoded to), so worked variant is

```
  func performDrop(info: DropInfo) -> Bool
  {
    if let item = info.itemProviders(for: ["public.utf8-plain-text"]).first
    {
      item.loadItem(forTypeIdentifier: "public.utf8-plain-text", options: nil)
      {
        (data, error) in
        if let data = data as? Data {
          print(NSString(data: data, encoding: 4) ?? "failed")
        }
      }
    }
    return true
  }
```

Tested with Xcode 13 / macOS 11.5.2

![3QwJa](https://user-images.githubusercontent.com/62171579/170252984-0da62e3f-8cd5-40ef-b7d1-86ffa8e5723c.png)
