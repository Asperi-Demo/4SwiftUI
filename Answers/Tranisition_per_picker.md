```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How can I update this custom Picker animation and transition to iOS 15? (by Rillieux)

    let swapRight: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    let swapLeft: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .trailing))

A: We need to add animation to container (`VStack` in this case) to make subviews animated, like

		VStack {
			Picker("", selection: $picker) {
				ForEach(0 ..< segments.count) { index in
					Text(self.segments[index])
						.tag(index)
				}
			}
			.pickerStyle(SegmentedPickerStyle())

			switch picker {
			case 0:
				Rectangle().fill(Color.green)
					.transition(swapLeft)
			case 1:
				Rectangle().fill(Color.yellow)
					.transition(swapRight)
			default:
				Rectangle().fill(Color.green)
					.transition(swapLeft)
			}
			Spacer()
		}
		.animation(swapAnimation, value: picker) // << here !!

Tested with Xcode 13 / iOS 15

![Zhgcm](https://user-images.githubusercontent.com/62171579/179395878-5d6933fd-00ec-441c-8c79-e07b82b1d0a2.gif)
