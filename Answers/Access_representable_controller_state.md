```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to call a uikit viewcontroller method from swiftui view (by John M)

A: Here is possible protocol/configurator based approach, which allows to use actions directly that looks more appropriate from code simplicity and readability.

```
protocol Player { // use protocol to hide implementation
    func play()
}

class PlayerViewController: UIViewController, Player {
    var player = Player()
    func play() {
        self.player.play()
    }
}

struct ProjectEditorPlayerBridge: UIViewControllerRepresentable {
    var configurator: ((Player) -> Void)? // callback

    func makeUIViewController(context: Context) -> PlayerViewController {
        let player = PlayerViewController()

        // callback to provide active component to caller
        configurator?(player)

        return player
    }

    func updateUIViewController(_ uiViewController: PlayerViewController, context: Context) {
    }

    typealias UIViewControllerType = PlayerViewController
}

struct DemoPlayerView: View {
    @State private var player: Player?     // always have current player

    var body: some View {
        VStack {
            ProjectEditorPlayerBridge { self.player = $0 }  // << here !!

            // use player action directly !!
            Button("Play", action: player?.play ?? {})
        }
    }
}

```
