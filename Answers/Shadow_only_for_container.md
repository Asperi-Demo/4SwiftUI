```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI, shadow only for container (by alexbayker)

A: Shadow is applied to something opaque, but any stack in SwiftUI is transparent, 
so we can add a background and apply a shadow to it, like in below example

![Y60RR](https://user-images.githubusercontent.com/62171579/163420234-c6be776a-0f28-4120-82a8-2f1cb9c572da.png)


```swift
  VStack {
    ...
  }
  .background(
    Color(UIColor.systemBackground) // any non-transparent background
      .shadow(color: Color.red, radius: 10, x: 0, y: 0)
  )
```

