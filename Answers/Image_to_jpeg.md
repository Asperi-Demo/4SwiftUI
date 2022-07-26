```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI: How to convert an Image to jpeg data? (by ajf1000)

A: The SwiftUI `Image` is analog of `UIImageView`, not `UIImage`. So if you need to operate with image model, you have to store it explicitly as `UIImage` and operate with it, providing into view as in below example:

```
struct ContentView: View {
   let imageModel: UIImage        // << model

   var body: some View {
      Image(uiImage: imageModel)  // << view
        .onTapGesture {
            // work with model

            let data = self.imageModel.jpegData(compressionQuality: 0.5)
            // .. do something with data
        }
   }
}
```


