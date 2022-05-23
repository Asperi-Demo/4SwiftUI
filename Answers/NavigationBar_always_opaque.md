```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Navigation bar only have background when scroll (by JonathanLiu)

A: We need opaque appearance, because `default` one means `system-selected-by-design` which is changed from version to version.

![3i5cI](https://user-images.githubusercontent.com/62171579/163330904-6afd5368-18d8-4e91-958b-d7167b7a5a5a.png)


        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

Tested with Xcode 13.3 / iOS 15.4 (in ContentView.init)

*Note: onAppear is too late to inject above code, the appearance settings are applied on objects created after it, and onAppear is called after NavigationView created. So use it either in init, or anywhere else, but before view created.*

[Test module here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestPersistentOpaqueNavBar.swift)
