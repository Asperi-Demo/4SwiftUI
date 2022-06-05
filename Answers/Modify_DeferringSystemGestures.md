```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: preferredScreenEdgesDeferringSystemGestures in SwiftUI (Aspid)

A: Just override it in custom hosting controllers

```
class MyHostingController<Content: View>: UIHostingController<Content> {
    open override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge{
        return [.all];
    }
}
```

and use it as root controller

    let window = UIWindow(windowScene: windowScene)

    let controller = MyHostingController(rootView: contentView)
    controller.setNeedsUpdateOfScreenEdgesDeferringSystemGestures()

    window.rootViewController = controller

