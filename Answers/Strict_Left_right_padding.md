```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Left and right padding (not leading and trailing) in SwiftUI (by Steve M)

A: Here is a simplified demo of possible approach - use extension with injected fixed-sized `Spacer` at each side.

Prepared & tested with Xcode 13 / iOS 15

```
enum Side: Equatable, Hashable {
	case left, right
}

extension View {
	func padding(sides: [Side], value: CGFloat = 8) -> some View {
		HStack(spacing: 0) {
			if sides.contains(.left) {
				Spacer().frame(width: value)
			}
			self
			if sides.contains(.right) {
				Spacer().frame(width: value)
			}
		}
	}
}
```

demo of usage

    var body: some View {
      TextField("Last Name", text: $nameLast)
        .textFieldStyle(.roundedBorder)
        .padding(sides: [.left], value: 20)
    }


![7mRWZ](https://user-images.githubusercontent.com/62171579/171558488-ae0d9276-833f-4363-8677-bb4c774c04e0.png)
