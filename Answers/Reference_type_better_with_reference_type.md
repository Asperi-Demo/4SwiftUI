```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Get AVPlayerItem track title with SwiftUI (by F.SO7)

A: This is the case when reference type is more preferable. So here is simplified demo of possible approach

```
import AVKit
import Combine

class RadioStreamer: NSObject, ObservableObject {
    @Published var itemTitle: String = "Unknown"

    let streamingURL: URL

    private let player: AVPlayer?
    private let playerItem: AVPlayerItem?

    init(streamingURL: URL) {
        self.streamingURL = streamingURL
        self.playerItem = AVPlayerItem(url: self.streamingURL)
        self.player = AVPlayer(playerItem: self.playerItem)

        super.init()

        // setup output for player item metadata
        let metaOutput = AVPlayerItemMetadataOutput(identifiers: [ // nil, for all
            // specify needed meta to be output, 
            AVMetadataIdentifier.commonIdentifierTitle.rawValue     
        ])
        metaOutput.setDelegate(self, queue: DispatchQueue.main)
        self.playerItem?.add(metaOutput)
    }

    public func playStreaming() { self.player?.play() }
}

extension RadioStreamer: AVPlayerItemMetadataOutputPushDelegate {
    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {

        // simplest demo, in common case iterate all groups and all items in group
        // to find what you need if you requested many metadata
        if let group = groups.first,
            let item = group.items.first {
            self.itemTitle = item.stringValue ?? "Unknown"
        }
    }
}
```
