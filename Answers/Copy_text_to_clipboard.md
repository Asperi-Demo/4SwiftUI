```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI - how to copy text to clipboard? (by Gerard)

A: Use the following - put shown text into pasteboard for specific type (and you can set as many values and types as needed)


**Update:** for Xcode 13+, because of "'kUTTypePlainText' was deprecated in iOS 15.0..."

```
import UniformTypeIdentifiers

Text(self.BLEinfo.sendRcvLog)
    .onTapGesture(count: 2) {
        UIPasteboard.general.setValue(self.BLEinfo.sendRcvLog,
            forPasteboardType: UTType.plainText.identifier)
    }
```

for older versions:

```
import MobileCoreServices // << for UTI types

// ... other code

Text(self.BLEinfo.sendRcvLog)
    .onTapGesture(count: 2) {
        UIPasteboard.general.setValue(self.BLEinfo.sendRcvLog, 
            forPasteboardType: kUTTypePlainText as String)
    }
```
