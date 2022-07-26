```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: AVSpeechSynthesizer isSpeaking not working in Swift (by Mike R)

A: It is just not updated in your case, because `synthesiser.isSpeaking` is not observable for SwiftUI. You have to use view model class and delegate callbacks to handle this state changes

Here is initial demo (you can add stop/pause/continue actions by yourself)

```
class SpeachViewModel: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
	@Published var isSpeaking = false

	private var synthesizer = AVSpeechSynthesizer()
	override init() {
		super.init()
		synthesizer.delegate = self
	}

    deinit {
		synthesizer.delegate = nil
    }

	func speak(_ utterance: AVSpeechUtterance) {
		self.synthesizer.speak(utterance)
	}

	// MARK: AVSpeechSynthesizerDelegate
	internal func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
		self.isSpeaking = true
	}

	internal func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
		self.isSpeaking = false
	}

	internal func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
		self.isSpeaking = false
	}

	internal func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
		self.isSpeaking = false
	}

	internal func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
		self.isSpeaking = true
	}
}

struct ContentView: View {

	@ObservedObject var vm = SpeachViewModel()
	var utterance = AVSpeechUtterance(string: "Hello World")

	var body: some View {
		VStack {
			Text(vm.isSpeaking ? "Speaking" : "Not Speaking")
			Button(action: {vm.speak(utterance)}) {
				Text("Speak To Me")
			}
		}
	}
}
```
