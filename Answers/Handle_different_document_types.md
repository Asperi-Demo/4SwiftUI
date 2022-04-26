```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to handle different document types in a document based macOS app? (by ChrisR)

A: The engine is still the same - `NSDocumentController`, so and behavior is the same, 
meaning that `NSDocumentController` has default type and default -newDocument action
which work for default (usually 1st) document type. All other document types should
be instantiated and added to shared controller programmatically. The positive moment
here is that declared `DocumentGroup` is matched and used correctly.

Here is a demo of approach based on two `DocumentGroups` where second one is just copy
of first with add "2" everywhere needed: identifiers in plist, document type, content view, etc.

Tested with Xcode 13.3 / macOS 12.2.1

```
@main
struct SwiftUI_macOS_TwoDocumentsApp: App {

  var body: some Scene {
    // The first is default (returned by @see NSDocumentController.defaultType)
    // and created by -newDocument action which is also one and default
    // Review NSDocumentController interface/documentation for details on behavior
    DocumentGroup(newDocument: SwiftUI_macOS_TwoDocumentsDocument()) { file in
      ContentView(document: file.$document)
    }

    // Any number of other supported documents can be listed from here, but
    // create new document should be done manually, although openning works as expected
    DocumentGroup(newDocument: SwiftUI_macOS_TwoDocumentsDocument2()) { file in
      ContentView2(document: file.$document)
    }
    .commands {
      // Use NSApp.mainMenu to inject to File > New > ... or recreate .newItem section completely,
      // which is probably better from management/support perspective
      CommandGroup(after: .newItem) { 
        Button("New Document2") {
          let dc = NSDocumentController.shared
          if let newDocument = try? dc.makeUntitledDocument(ofType: "com.example2.plain-text") {
            dc.addDocument(newDocument)
            newDocument.makeWindowControllers()
            newDocument.showWindows()
          }
        }
      }
    }
  }
}
```
