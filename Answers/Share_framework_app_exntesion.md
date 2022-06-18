```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I properly share the Amplify framework with my Main App and my App Extension for an iOS app? (by alionthego)

A: Just remove explicit `Amplify` dependency from extension, ie. next section should be empty

![f7rer](https://user-images.githubusercontent.com/62171579/174423028-77d915e2-8f68-407e-a50e-e7ef0155b329.png)

Make sure (it should be automatically, but anyway)

1. *Link Frameworks Automatically* parameter (in Build Settings) is `true`

![UL2lT](https://user-images.githubusercontent.com/62171579/174423034-c49d23c1-e459-4456-97bc-9056769c736c.png)

2. *Runpath Search Path* parameter is related to main bundle

![IJNYs](https://user-images.githubusercontent.com/62171579/174423039-76ef8b0a-c44c-4bf9-bd51-e5071f387e66.png)

So as targets from SPM are built in same location as product and extension and automatic framework linking is enabled the imported modules in extension will available and linked automatically and due to run paths are set the frameworks will be found in run-time as well.

*Note: of course in main app target all should be included*

![ViEGI](https://user-images.githubusercontent.com/62171579/174423047-249f8e35-6125-415e-8e76-a2735eb72c5b.png)

Tested with Xcode 13.1 / iOS 15.1
