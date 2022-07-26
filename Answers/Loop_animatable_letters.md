```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Animating the letters in a word w the app opens - SwiftUI (by JustMe)

A: ### Update: with Xcode 13.4 / iOS 15.5

Animation is based on changed states, we switched states and view animated to the new states, so to rollback we need to switch the states back.

Here is the possible approach (might still require tuning, but is ok for demo)

![Z7XZo](https://user-images.githubusercontent.com/62171579/180373770-be3510f1-239e-4f5e-82d2-c6efdd3d35d0.gif)

```
struct ContentView: View {
	let letters = Array("Math Fun!")
	@State private var enabled = false
	@State private var dragAmount = CGSize.zero

	var body: some View {
		HStack(spacing: 0) {
			ForEach(0..<letters.count, id: \.self) { num in
				Text(String(self.letters[num]))
					.padding(5)
					.font(.title)
					.background(self.enabled ? Color.blue : Color.red)
					.offset(self.dragAmount)
					.animation(Animation.default.delay(Double(num)/20), value: enabled)
			}
		}
		.onAppear {
			self.dragAmount = CGSize(width: 0, height: 80)
			self.enabled.toggle()
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				self.dragAmount = .zero
				self.enabled.toggle()
			}
		}
	}
}
```
