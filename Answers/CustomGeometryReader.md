```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can we make a Custom GeometryReader in SwiftUI? (by swiftPunk)

A: Ok, there are several instruments in SwiftUI providing access to view size (except `GeometryReader` of course).

The problem of course is to transfer that size value into view build phase, because only `GeometryReader` allows to do it in same build cycle.

Here is a demo of possible approach using `Shape` - a shape by design has no own size and consumes everything available, so covers all area, and has been provided that area rect as input.

Tested with Xcode 13 / iOS 15

```
struct CustomGeometryReaderView<Content: View>: View {

	@ViewBuilder let content: (CGSize) -> Content

	private struct AreaReader: Shape {
		@Binding var size: CGSize

		func path(in rect: CGRect) -> Path {
			DispatchQueue.main.async {
				size = rect.size
			}
			return Rectangle().path(in: rect)
		}
	}

	@State private var size = CGSize.zero

	var body: some View {
        // by default shape is black so we need to clear it explicitly
		AreaReader(size: $size).foregroundColor(.clear)
			.overlay(Group {
				if size != .zero {
					content(size)
				}
			})
	}
}
```

**Alternate:** same, but using callback-based pattern

```
struct CustomGeometryReaderView<Content: View>: View {

	@ViewBuilder let content: (CGSize) -> Content

	private struct AreaReader: Shape {
		var callback: (CGSize) -> Void

		func path(in rect: CGRect) -> Path {
			callback(rect.size)
			return Rectangle().path(in: rect)
		}
	}

	@State private var size = CGSize.zero

	var body: some View {
		AreaReader { size in
			if size != self.size {
				DispatchQueue.main.async {
					self.size = size
				}
			}
		}
		.foregroundColor(.clear)
		.overlay(Group {
			if size != .zero {
				content(size)
			}
		})
	}
}
```
