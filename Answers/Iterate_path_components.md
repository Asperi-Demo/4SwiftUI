```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to iterate over all segments/points of a Path of a Shape in SwiftUI? (by Erik)

A: SwiftUI `Shape` does not have own size, so you need to provide/request rect of area where shape will be used. So here is a demo of possible approach to go with:

```
public func checkPath<S: Shape>(shape: S, in rect: CGRect) {
  shape.path(in: rect).forEach { element in
    switch element {
      case .move(to: let point):
        print("Calculate here move to: \(point)")
      case .line(to: let point):
        print("Calculate here line to: \(point)")
      // .. handle other cases here
      default:
        print("Ignore unsupported")
    }
  }
}
```
