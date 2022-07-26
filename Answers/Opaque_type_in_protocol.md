```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - Returning an opaque type in a protocol (by Above The Gods)

A: Here is variant using protocol `associatedtype`, actually SwiftUI native approach, if we see in its auto-generated module. This allows to avoid type-erasure wrappers and use view directly.

Tested with Xcode 11.4 / iOS 13.4

```
protocol Media {
    associatedtype Summary : View
    func displaySummary() -> Self.Summary
}

final class Playlist: Media, Identifiable {
    @ViewBuilder
    func displaySummary() -> some View {
        HStack {
            Text("Summary")
                .padding(.all)
                .background(Color.black)
        }
    }
}

struct PlaylistView: View {
    let playlist = Playlist()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            playlist.displaySummary()
        }
    }
}
```
