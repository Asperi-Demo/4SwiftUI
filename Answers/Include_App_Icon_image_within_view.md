```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How do I include iOS App Icon image within the app itself? (by Snips)

A: The following works *if* app icon is correctly set for used device (ie. iPhone icons for iPhone, etc.)

*Note: sizes of app icons must match exactly!*

Tested with Xcode 11.4

![gygSX](https://user-images.githubusercontent.com/62171579/165229089-3fad1d90-c419-4703-be58-828261f52073.png)

![MBVrq](https://user-images.githubusercontent.com/62171579/165229118-6c8006eb-26a1-45a4-9a37-ad045b7ccc5f.png)

```
Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
```
