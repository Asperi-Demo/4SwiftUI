```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Opening Xcode 13.0 project in Xcode 12.5 (by unknown)

A: Make the following (tested with Xcode 13 and Xcode 12.5):

1) Locate `.xcodeproj` in Finder and drop inside bundle using *Open Package Contents*

![OQjYg](https://user-images.githubusercontent.com/62171579/170932837-e7e75a2d-5e8c-4915-9f78-b286e5f9f899.png)

2) Open `project.pbxproj` in any text editor (eg. TextEdit)

![NOqEx](https://user-images.githubusercontent.com/62171579/170932852-8fb441eb-01d5-4ce1-9ccb-9fbc10d041d1.png)

3) Find, change `objectVersion = 55` to **objectVersion = 46** (!!), then save and quit

![5VBT4](https://user-images.githubusercontent.com/62171579/170932882-266d6773-375e-44c2-9c31-c58f37078a29.png)

4) Open your `xcodeproj` in Xcode 12.5 - Done

*Note: I did not check how far it will be operable - probably depends on project complexity, but that can be fixed step by step I assume.*

