```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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
