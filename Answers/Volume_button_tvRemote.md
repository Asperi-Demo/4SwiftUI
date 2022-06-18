```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to detect volume button press on tvOS remote (by kaddie)

A: It is not clear all other code, but you have to keep reference to created observer.

Here is possible solution (tested with Xcode 12.1)

	private var observer: NSKeyValueObservation?

    // ... other code
	
	self.observer = audioSession?.observe(\.outputVolume) { [weak self] (audioSession, _) in
		guard let `self` = self else { return }
		let mute = audioSession.outputVolume
		
		var isMuted = false
		if (mute == 0) && (!self.player.isMuted) {
			isMuted = true
		} else if (mute.isZero) && (self.player.isMuted) {
			isMuted = false
		}
		
		// do what's needed here with `isMuted`
	}



