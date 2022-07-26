```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Drag and drop with custom type identifier doesn't work (by Procrastin8)

A: The `typeIdentifier` in above is not just a unique string, it **must be UTI**. 

If you want to use some custom-application-specifc UTI (think twice if you really need it), then you have to register one according to Apple rules, starting from 

```
<key>UTExportedTypeDeclarations</key>
        <array>
            <dict>
                <key>UTTypeIdentifier</key>
                <string>com.procrastin8.plzwork</string>
                ...
```

in app `Info.plist`

See details specifically in [Declaring New Uniform Type Identifiers](https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_declare/understand_utis_declare.html#//apple_ref/doc/uid/TP40001319-CH204-SW1)

And wide collection in [Technical Q&A QA1796](https://developer.apple.com/library/archive/qa/qa1796/_index.html)
