```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Publishing and Consuming a transcript from SFSpeechRecognizer (by Wesley)

A: Subscription should be stored otherwise it is canceled immediately, also you need to make subscription before actual usage (and some other memory related modifications made). So I assume you wanted something like:

```
class ViewModel : ObservableObject {
    @Published var SpeechText: String = ""
    var speech: SpeechRecognizer = SpeechRecognizer()  // << here !!

	private var subscription: AnyCancellable? = nil    // << here !!
    public init() {
        self.subscription = speech.transcript.publisher  // << here !!
            .map { $0 as! String? ?? "" }
            .sink(receiveCompletion: {
                print ($0) },
                  receiveValue: { [weak self] value in
                    self?.SpeechText = value
                    self?.doStuffWithText(transcript: value)
                  })
        self.speech.transcribe()                  // << here !!
    }

    private func doStuffWithText(transcript: String) {
        //Process the output as commands in the application
    }
}
```

Tested with Xcode 13.2
