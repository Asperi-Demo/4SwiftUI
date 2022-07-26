```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Getting SwiftUI wrapper of AVPlayer to pause when view disappears (by Andrew Duncan)

A: Well... on

>     }.onDisappear {
>         print("> onDisappear()")
>         self.router.isPlayingAV = false
>         print("< onDisappear()")
>     }

this is called **after** view is removed (it is like `didRemoveFromSuperview`, not `will...`), so I don't see anything *bad/wrong/unexpected* in that subviews (or even it itself) is not updated (in this case `updateUIView`)... I would rather surprise if it would be so (why update view, which is not in view hierarchy?!). 

So this 

>     class DummyClass { } ; let x = DummyClass()

is rather some *wild* bug, or ... bug. Forget about it and never use such stuff in releasing products.

OK, one would now ask, how to do with this? The main issue I see here is design-originated, specifically tight-coupling of model and view in `PlayerUIView` and, as a result, impossibility to manage workflow. `AVPlayer` here is not part of view - it is model and depending on its states `AVPlayerLayer` draws content. Thus the solution is to tear apart those entities and manage separately: views by views, models by models.

Here is a demo of modified & simplified approach, which behaves as expected (w/o weird stuff and w/o Group/ZStack limitations), and it can be easily extended or improved (in model/viewmodel layer)

Tested with Xcode 11.2 / iOS 13.2

Complete module code (can be copy-pasted in `ContentView.swift` in project from template)

    import SwiftUI
    import Combine
    import AVKit
    
    struct MovieView: View {
        @EnvironmentObject var router: ViewRouter
    
        // just for demo, but can be interchangable/modifiable
        let playerModel = PlayerViewModel(url: Bundle.main.url(forResource: "myVid", withExtension: "mp4")!)
    
        var body: some View {
            VStack() {
                PlayerView(viewModel: playerModel)
                Button(action: { self.router.page = .home }) {
                    Text("Go back Home")
                }
            }.onAppear {
                self.playerModel.player?.play() // << changes state of player, ie model
            }.onDisappear {
                self.playerModel.player?.pause() // << changes state of player, ie model
            }
        }
    }
    
    class PlayerViewModel: ObservableObject {
        @Published var player: AVPlayer? // can be changable depending on modified URL, etc.
        init(url: URL) {
            self.player = AVPlayer(url: url)
        }
    }
    
    struct PlayerView: UIViewRepresentable { // just thing wrapper, as intended
        var viewModel: PlayerViewModel
    
        func makeUIView(context: Context) -> PlayerUIView {
            PlayerUIView(frame: .zero , player: viewModel.player) // if needed viewModel can be passed completely
        }
    
        func updateUIView(_ v: PlayerUIView, context: UIViewRepresentableContext<PlayerView>) {
        }
    }
    
    class ViewRouter : ObservableObject {
        enum Page { case home, movie }
    
        @Published var page = Page.home // used native publisher
    }
    
    class PlayerUIView: UIView {
        private let playerLayer = AVPlayerLayer()
        var player: AVPlayer?
    
        init(frame: CGRect, player: AVPlayer?) { // player is a model so inject it here
            super.init(frame: frame)
    
            self.player = player
            self.playerLayer.player = player
            self.layer.addSublayer(playerLayer)
        }
    
        override func layoutSubviews() {
            super.layoutSubviews()
            playerLayer.frame = bounds
        }
    
        required init?(coder: NSCoder) { fatalError("not implemented") }
    }
    
    struct ContentView: View {
        @EnvironmentObject var router: ViewRouter
    
        var body: some View {
            Group {
                if router.page == .home {
                    Button(action: { self.router.page = .movie }) {
                        Text("Go to Movie")
                    }
                } else if router.page == .movie {
                    MovieView()
                }
            }
        }
    }
    
