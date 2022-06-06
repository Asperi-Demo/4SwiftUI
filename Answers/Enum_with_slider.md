```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I change a variable with an enum as a type, using a slider in SwiftUI? (by Ribena)

A: By default `Slider` is continuous in range, so important part for mapping to enum is to give it a step. 

Here is possible solution. Tested with Xcode 12.4 / iOS 14.4

![YHmtz](https://user-images.githubusercontent.com/62171579/172112162-7dbe492a-c39b-4149-80d0-0280889df400.gif)

Below are modified parts only:

```
enum MyType: Int, CaseIterable, Codable {
	case zero = 4
	case one = 2
	case two = 7
	case three = 5

	init(index: Double = 0) {
		if let type = Self.allCases.first(where: { $0.asIndex == index }) {
			self = type
		} else {
			self = .zero
		}
	}

	var asIndex : Double {
		switch self {
		case .zero: return 0
		case .one: return 1
		case .two: return 2
		case .three: return 3
		}
	}
}

// VIEWS
struct MyView: View {
	@Binding var myModel: MyModel

	var body: some View {

		Slider(value: Binding(
			get: { myModel.myValue.asIndex },
			set: { myModel.myValue = MyType(index: $0) }
		), in: 0...3, step: 1)                             // give step !!

		Text("\(myModel.myValue.rawValue)" as String) // 4, 2, 7 or 5 depending on the slider being set to values 0,1,2 or 3
	}
}
```
