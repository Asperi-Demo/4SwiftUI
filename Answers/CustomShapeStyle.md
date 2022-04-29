```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I conform to ShapeStyle protocol in SwiftUI? (by iosDev)

A: **Disclaimer:** *below is only for demo, because all used API are private (by convention, not by design), so reaction of Apple if you submit app with such code to AppStore is unpredictable.*

The `ShapeStyle` is actually opaque protocol by SwiftUI interface, ie. all its *behavior* functions are hidden by Xcode because have prefix "_", but if we look into .swiftinterface file of SwiftUI.framework then we can find that it requires three methods to be implemented:

**Note: as used interfaces are private they can be changed with any new version.**

```
struct RedView: ShapeStyle {
  public static func _makeView<S>(view: SwiftUI._GraphValue<SwiftUI._ShapeView<S, SwiftUI.Color>>, inputs: SwiftUI._ViewInputs) -> SwiftUI._ViewOutputs where S : SwiftUI.Shape {
	Color._makeView(view: view, inputs: inputs)
  }

  public func _apply(to shape: inout SwiftUI._ShapeStyle_Shape) {
	Color.red._apply(to: &shape)  // << here !!
  }

  public static func _apply(to type: inout SwiftUI._ShapeStyle_ShapeType) {
	Color._apply(to: &type)
  }
}
```

Which gives on Xcode 13.3 / iOS 15.4

![F7fO4](https://user-images.githubusercontent.com/62171579/165888697-38effbf9-0f5d-41f7-895a-2e44990faba0.png)
