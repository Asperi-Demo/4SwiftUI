```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI Drag and Drop files (by davidev)

A: Here is a demo of drag & drop, tested with Xcode 11.4 / macOS 10.15.4. 

Initial `image` is located on assets library, accepts drop (for simplicity only) as file url from Finder/Desktop (drop) and to TextEdit (drag), registers drag for TIFF representation.

    struct TestImageDragDrop: View {
        @State var image = NSImage(named: "image")
        @State private var dragOver = false

        var body: some View {
            Image(nsImage: image ?? NSImage())
                .onDrop(of: ["public.file-url"], isTargeted: $dragOver) { providers -> Bool in
                    providers.first?.loadDataRepresentation(forTypeIdentifier: "public.file-url", completionHandler: { (data, error) in
                        if let data = data, let path = NSString(data: data, encoding: 4), let url = URL(string: path as String) {
                            let image = NSImage(contentsOf: url)
                            DispatchQueue.main.async {
                                self.image = image
                            }
                        }
                    })
                    return true
                }
                .onDrag {
                    let data = self.image?.tiffRepresentation
                    let provider = NSItemProvider(item: data as NSSecureCoding?, typeIdentifier: kUTTypeTIFF as String)
                    provider.previewImageHandler = { (handler, _, _) -> Void in
                        handler?(data as NSSecureCoding?, nil)
                    }
                    return provider
                }
                .border(dragOver ? Color.red : Color.clear)
        }
    }

