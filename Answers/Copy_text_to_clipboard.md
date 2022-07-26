```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
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
