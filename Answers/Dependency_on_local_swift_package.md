```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Add dependency on a local swift package in Xcode 11 (by Guig)

A: Here is literally what I do and it just works... Xcode 11.2

I. Prepare package

1. File > New > Swift Package > Select Empty Folder (or create new) > Enter Library Name (MyLibrary)

2. Here in project find MyLibrary.swift and make public structure & variable, so there is some export to use in app (I made static constant and fixed UT)

3. Build > OK > Close Project

II. Prepare project

1. File > New > Project > iOS > Single View App > Enter Name (MyApp) > Next > Select Same Folder as above (it is by default) > Create

2. Build > OK

3. From Finder drag MyLibrary folder right below project name in Xcode Project Navigator

4. Build > OK

5. Click MyApp project icon in Project Navigator > Select MyApp application target > section Frameworks, Libraries, … click + > In topmost Workspace section select MyLibrary > Add

6. Clean > Build > OK

7. Open ContentView.swift > type `import MyLibrary` (autocompletion already see it)
Replace “Hello, World” with "\(MyLibrary.text)"

8. Build & Run > OK

That’s it.

To verify used relative path open project.pbxproj in TextEdit, here is screenshot

![BT6i5](https://user-images.githubusercontent.com/62171579/163548326-5944dfbd-0a6e-48bd-bc91-3f2d6241ba67.png)

**Update:** <br>
*Note1* - I've considered some delay in package resolving after Clean, so during some period of time, 1-2 mins here, Build fails exactly with reported error, but after that delay it is visible that index restarted and following Build succeeded.<br>
*Note2* - Adding second dependent package in graph (MyApp > MyLibrary > AnotherLibrary) is the same.
