```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Populating Localizable.strings file with Terminal genstring command in SwiftUI (by Esowes)

A: Use `-SwiftUI` option (as in variant below, or any other used)

```
$ find ./ -name "*.swift" -print0 | xargs -0 genstrings -a -SwiftUI -o en.lproj
```

for details

```
$ man genstrings
```
