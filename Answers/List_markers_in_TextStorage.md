>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: ios - Replace/delete characters [• ] in UITextView on Enter (by mahan)

A: All logic is in `TextStorage` class, everything else is just standard. Tested with Xcode 11.4 / iOS 13.4

![uLyvg](https://user-images.githubusercontent.com/62171579/187061391-52e4f830-f781-41d4-9e25-57ca9df2eae0.gif)

```
class TextStorage: NSTextStorage {

    override func replaceCharacters(in range: NSRange, with str: String) {

        var listPrefix: String? = nil
        if (TextUtils.isReturn(str: str)) {

            let currentLine = TextUtils.startOffset(self.string, location: range.location).0
            let separateds = currentLine.components(separatedBy: " ")

            if separateds.first!.contains("•") && currentLine.trimmingCharacters(in: .whitespaces).count == 1  {
                listPrefix = ""
            }

            else {
                if separateds.count >= 2 {
                    if separateds.first!.contains("•") {
                        listPrefix = "• "
                    }
                }
            }
        }

        beginEditing()
        backingStore.replaceCharacters(in: range, with:str)
        edited(.editedCharacters, range: range, changeInLength: (str as NSString).length - range.length)
        endEditing()


        guard let prefix = listPrefix else {
            return
        }


        if  prefix.isEmpty {
            let text = string.split(separator: "\n")
            let next = NSMakeRange(textView.selectedRange.location - (text.last!.count) - 1, text.last!.count + 1)
            replaceCharactersInRange(next, withString: " ", selectedRangeLocationMove: 0)
        } else {
            let newRange  = NSMakeRange(textView.selectedRange.location + str.count, 0)
            replaceCharactersInRange(newRange, withString: prefix, selectedRangeLocationMove: prefix.count)
        }
    }


    override func setAttributes(_ attrs: [NSAttributedString.Key: Any]?, range: NSRange) {
        guard range.upperBound <= string.count else { return }

        beginEditing()
        backingStore.setAttributes(attrs, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
```

Original helper:

```
class TextUtils {

    class func isReturn(str: String) -> Bool {
        return str == "\n"
    }

    class func isBackspace(str: String) -> Bool {
        return str == ""
    }

    class func startOffset(_ string: String, location: Int) -> (String, Int) {

        var offset: Int = 0
        var word = NSString(string: string).substring(to: location)
        let lines = string.components(separatedBy: "\n")

        if lines.count > 0 {
            let last = lines.last!

            offset = word.count - last.count
            word = last
        }

        return (word, offset)
    }
}
```
