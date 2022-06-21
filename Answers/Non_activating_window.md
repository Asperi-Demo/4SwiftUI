```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Swift - how to make window unactivable? (by Andrew____Pls_Support_Ukraine)

A: Actually all you need is `.nonactivatingPanel` style panel. Everything else is details, like level of this window, custom views with overridden `acceptsFirstMouse:`, `needsPanelToBecomeKey`, etc. Btw, button accepts first click by default, non activating app in this case.

So your `AppDelegate`, for example, might look like the following:

    class AppDelegate: NSObject, NSApplicationDelegate {
    
        var docky: NSPanel!
    
        func applicationDidFinishLaunching(_ aNotification: Notification) {
    
            // Create the window and set the content view. 
            docky = NSPanel(
                contentRect: NSRect(x: 0, y: 0, width: 120, height: 600),
                styleMask: [.nonactivatingPanel],
                backing: .buffered, defer: false)
            docky.level = .mainMenu
            ....
            docky.orderFrontRegardless()
        }

