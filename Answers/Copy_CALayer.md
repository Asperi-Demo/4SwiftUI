```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to properly copy CAShapeLayer in swift? (by Lucas)

A: `CALayer` does not conform to `NSCopying` from API, but it conforms to `NSSecureCoding`, so it is possible to add copying capability as below

> Tested with Xcode 11.2 / iOS 13.2 (with CAShapeLayer &
> CAGradientLayer)

    extension CALayer : NSCopying {
        public func copy(with zone: NSZone? = nil) -> Any {
            if let data = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false) {
                if let newInstance = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) {
                    return newInstance
                }
            }
            fatalError() // << should never got here
        }
    }

Now, it is possible to call `layer.copy()` to any layer (theoretically) without exception.
