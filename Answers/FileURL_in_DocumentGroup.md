```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to read large files using SwiftUI DocumentGroup without making a temporary copy? (by olilarkin)

A: We can get `fileURL` via document configuration, like 

```
@main
struct MyApp: App {
    var body: some Scene {
        DocumentGroup(viewing: MyDocument.self) { fileConfig in
            // here fileConfig has `fileURL` of opened document, so 
            MyViewer(content: fileConfig.document, url: fileConfig.fileURL)
        }
    }
}
```
