```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Exceeding max Text("") concatenation length - SwiftUI (by JerseyDevel)

A: Here is improved algorithm, which should move that limitation far away. 

![e8Wbn](https://user-images.githubusercontent.com/62171579/175787724-2f3cbafd-d881-4e7f-a69d-1eed45d1e9fc.png)

Tested with Xcode 12 / iOS 14. (also updated code in referenced topic [Highlight a specific part of the text in SwiftUI](https://stackoverflow.com/a/62111947/12299030))

    func hilightedText(str: String, searched: String) -> Text {
        guard !str.isEmpty && !searched.isEmpty else { return Text(str) }

        var result = Text("")

        var range = str.startIndex..<str.endIndex
        repeat {
            guard let found = str.range(of: searched, options: .caseInsensitive, range: range, locale: nil) else {
                result = result + Text(str[range])
                break
            }

            let prefix = str[range.lowerBound..<found.lowerBound]
            result = result + Text(prefix) + Text(str[found]).bold().foregroundColor(.yellow)

            range = found.upperBound..<str.endIndex
        } while (true)

        return result
    }

