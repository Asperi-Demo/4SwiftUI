```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - fade out a ScrollView (by Ulrich)

A: ### Updated with Xcode 13.4 / iOS 15.5

Now tap through gradient works with `.allowsHitTesting(false)`

![ezgif com-gif-maker-76](https://user-images.githubusercontent.com/62171579/180135043-ed294441-d014-4390-a052-2b88394580bc.gif)

### Original

Ok, it is known SwiftUI issue that it does not pass some gestures via overlays even transparent.

Here is possible approach to solve this - the idea is to have gradient to cover only small edge location, so other part of scroll view be accessed directly (yes, under gradient it will be still not draggable, but it is small part).

Demo prepared & tested with Xcode 11.7 / iOS 13.7

(simplified variant of original view)

```
struct HealthExportPreview: View {
    var body: some View {
        GeometryReader { gp in
            ZStack {
                ScrollView(.horizontal) {
                    HStack {
                       // simplified content
                        ForEach(0..<20, id: \.self) { index in
                            Rectangle().fill(Color.red)
                                .frame(width: 40, height: 80)
                        }
                    }
                    .padding()
                }
                .clipped()

                // inject gradient at right side only
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: Color(UIColor.systemBackground).opacity(0.01), location: 0),
                            .init(color: Color(UIColor.systemBackground), location: 1)
                        ]), startPoint: .leading, endPoint: .trailing)
                    ).frame(width: 0.2 * gp.size.width)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                    .allowsHitTesting(false)  // << now works !!

            }.fixedSize(horizontal: false, vertical: true)
        }
    }
}
```
