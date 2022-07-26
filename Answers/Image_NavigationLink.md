```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI NavigationView not see Image (by Artem)

A: This looks like SwiftUI bug of handling raster images. Please find below approach for workaround. Tested with Xcode 11.4 / iOS 13.4

![ENfaT](https://user-images.githubusercontent.com/62171579/177610287-cfc4985a-a780-417e-9ef5-f9df5f47c9d9.png)

This is an example of cell to be used for your goal. Of course in real case the image name and navigation link destination, etc., can be injected via constructor parameters for reuse purpose.

```swift
struct TestImageCell: View {
    @State private var isActive = false

    var body: some View {
        Image("large_image")    // raster !! image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 370, height: 200)
            .cornerRadius(20.0)
            .overlay(
                Text("Press on me")              // text is over
                    .foregroundColor(.white)
                    .font(.largeTitle)
            )
            .onTapGesture { self.isActive.toggle() } // activate link on image tap
            .background(NavigationLink(destination:  // link in background
                Text("Detail view here"), isActive: $isActive) { EmptyView() })
    }
}
```
