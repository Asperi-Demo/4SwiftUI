>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Is there a way to define discrete steps for a Slider? (by ElliotD)

A: Here is a possible approach - wrap system `Slider` into custom slider with remapping logic.

Demo (simple variant) is prepared & tested with Xcode 13 / iOS 15

![LdYhp](https://user-images.githubusercontent.com/62171579/189521837-77b44dfc-c102-48aa-9ecf-1fbf28b50aa2.gif)

```
struct TestIrregularSliderView: View {
	@State private var current = 500
	var body: some View {
		VStack {
			IrregularSlider(value: $current, in: [100, 500, 600, 1000, 10000])
			Text("Value: \(current)")
		}
	}
}

struct IrregularSlider<T: Comparable>: View {
	@Binding var value: T
	let values: [T]
	private let upperBound: Float
	@State private var index: Int

	init(value: Binding<T>, in values: [T]) {
		self._value = value
		self._index = State(initialValue: values.firstIndex(of: value.wrappedValue) ?? 0)

		self.values = values
		self.upperBound = Float(values.count - 1)
	}

	var body: some View {
		Slider(value: Binding(
			get: { Float(index) },
			set: { index = Int($0); value = values[Int($0)] }
		), in: 0...upperBound, step: 1)
	}
}
```
