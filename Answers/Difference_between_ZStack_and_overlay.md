```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Difference between a ZStack or using .overlay() (by Michael Ozeryansky)

A: In `ZStack` views are independent on each other and stack fits (if does not have own frame) to biggest view. Also order in ZStack can be modified by using `.zIndex` modifier. All views are in ZStack coordinate space.

In `.overlay` case the view inside overlay always bound to parent view and always *above* parent view (ie. zIndex does not play any role). Also overlaid views are in parent view coordinate space.

The most visible difference is if to make views different size and apply clipping, ie

```
struct TestZStack: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(systemName: "folder")
                .font(.system(size: 55, weight: .thin))
            Text("❤️").font(.system(size: 55, weight: .thin))
        }
        .clipped()
    }
}
```
gives
![UoaO7](https://user-images.githubusercontent.com/62171579/163397304-993965ec-845e-452e-9d25-e73a4ba86379.png)


```
struct TestOverlay: View {
    var body: some View {
        Image(systemName: "folder")
            .font(.system(size: 55, weight: .thin))
            .overlay(Text("❤️").font(.system(size: 55, weight: .thin)), alignment: .bottom)
            .clipped()
    }
}
```
gives 
![5ue9C](https://user-images.githubusercontent.com/62171579/163397365-177ab48d-b314-4184-b72f-8064c49bfc06.png)


