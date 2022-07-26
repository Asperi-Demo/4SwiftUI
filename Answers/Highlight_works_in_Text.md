```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Highlight a specific part of the text in SwiftUI (by Damiano Miazzi)

A: If that requires just simple word styling then here is possible solution.

Tested with Xcode 11.4 / iOS 13.4

![Txcz9](https://user-images.githubusercontent.com/62171579/175787882-c3025d13-6249-4155-8853-5785736b1dd7.png)

```
struct ContentView: View {
    let testo : String = "There is a thunderstorm in the area. Added some testing long text to demo that wrapping works correctly!"


    var body: some View {
        hilightedText(str: testo, searched: "thunderstorm")
            .multilineTextAlignment(.leading)
    }

    func hilightedText(str: String, searched: String) -> Text {
        guard !str.isEmpty && !searched.isEmpty else { return Text(str) }

        var result: Text!
        let parts = str.components(separatedBy: searched)
        for i in parts.indices {
            result = (result == nil ? Text(parts[i]) : result + Text(parts[i]))
            if i != parts.count - 1 {
                result = result + Text(searched).bold()
            }
        }
        return result ?? Text(str)
    }
}
```

**Note:** below is previously used function, but as commented by [@Lkabo](https://stackoverflow.com/users/1174318/lkabo) it has limitations on very long strings

    func hilightedText(str: String) -> Text {
        let textToSearch = "thunderstorm"
        var result: Text!
 
        for word in str.split(separator: " ") {
            var text = Text(word)
            if word == textToSearch {
                text = text.bold()
            }
            result = (result == nil ? text : result + Text(" ") + text)
        }
        return result ?? Text(str)
    }

