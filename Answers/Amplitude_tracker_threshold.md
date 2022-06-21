```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: AudioKit - How to use AKAmplitudeTracker threshold callback? (by Thomas Besnehard)

A: The following code works. Tested with AudioKit 4.9, Xcode 11.2, macOS Playground.

This might be an issue of AudioKit, but threshold must be changed via property to activate tracking, as shown below...

    import AudioKitPlaygrounds
    import AudioKit
    
    let mic = AKMicrophone()
    
    AKSettings.audioInputEnabled = true
    let amplitudeTracker = AKAmplitudeTracker(mic, halfPowerPoint: 10, threshold: 1, thresholdCallback: { (success) in
        print("thresholdCallback: \(success)")
    })
    AudioKit.output = amplitudeTracker
    
    try AudioKit.start()
    amplitudeTracker.threshold = 0.01 // !! MUST BE SET VIA PROPERTY
    amplitudeTracker.start()
    mic?.start()
    
    import PlaygroundSupport
    PlaygroundPage.current.needsIndefiniteExecution = true

