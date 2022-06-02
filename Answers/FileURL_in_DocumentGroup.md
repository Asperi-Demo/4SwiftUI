```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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
