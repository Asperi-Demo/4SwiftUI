```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Downsize but not upsize a SwiftUI image (by Daniel Ryan)

A: I did not find simple solution in API either, so here is a placeholder that looks appropriate for me. It is a bit complicated by works. 

Tested with Xcode 11.2+ / iOS 13.2+.

![V0j6q](https://user-images.githubusercontent.com/62171579/170832060-cf21466d-01a6-45c3-9f97-48c4d310d0e0.png)

Demo of usage:

```
struct DemoImagePlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ImagePlaceholder(image: Image("icon"), size: CGSize(width: 200, height: 200))
                .border(Color.red)
            ImagePlaceholder(image: Image("large_image"), size: CGSize(width: 200, height: 200))
                .border(Color.red)
        }
    }
}
```

Solution:

```
struct OriginalImageRect {
    var rect: Anchor<CGRect>? = nil
}

struct OriginalImageRectKey: PreferenceKey {
    static var defaultValue: OriginalImageRect = OriginalImageRect()

    static func reduce(value: inout OriginalImageRect, nextValue: () -> OriginalImageRect) {
        value = nextValue()
    }
}

struct ImagePlaceholder: View {
    let image: Image
    let size: CGSize

    var body: some View {
        VStack {
            self.image.opacity(0)
                .anchorPreference(key: OriginalImageRectKey.self, value: .bounds) {
                    OriginalImageRect(rect: $0)
                }
        }
        .frame(width: size.width, height: size.height)
        .overlayPreferenceValue(OriginalImageRectKey.self) { pref in
            GeometryReader { gp -> Image in
                if pref.rect != nil, CGRect(origin: .zero, size: gp.size).contains(gp[pref.rect!]) {
                    return self.image
                } else {
                    return self.image.resizable() // .fill by default, otherwise needs to wrap in AnyView
                }
            }
        }
    }
}
```
