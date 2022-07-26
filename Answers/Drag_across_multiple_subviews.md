```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI drag gesture across multiple subviews (by Acorn)

A: Here is a demo of possible approach... (it is simplified version of 
your app data settings, but the idea and direction where to evolve should be clear)

The main idea that you capture drag not in item view but in the content 
view transferring needed states (or calculable dependent data) into item 
view when (or if) needed.

![nB1qh](https://user-images.githubusercontent.com/62171579/165250820-5af6f07c-be5f-4a19-8306-12cbee72bc77.gif)


    struct PlayerView: View {
        var scaled: Bool = false
        var player: Player = Player(name: "Phile", color: .green, age: 42)
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                Rectangle().frame(width: 100, height: 100).foregroundColor(player.color).cornerRadius(15.0).scaleEffect(scaled ? 1.5 : 1)
                
                VStack {
                    Text(player.name)
                    Text("Age: \(player.age)")
                }.padding([.top, .leading], 10)
            }.zIndex(scaled ? 2 : 1)
        }
    }


    struct ContentView: View {
        @EnvironmentObject var data: PlayerData
    
        @GestureState private var location: CGPoint = .zero
        @State private var highlighted: Int? = nil
        
        private var Content: some View {
            VStack {
                HStack {
                    ForEach(0..<3) { i in
                        PlayerView(scaled: self.highlighted == i, player: self.data.players[i])
                            .background(self.rectReader(index: i))
                    }
                }
                .zIndex((0..<3).contains(highlighted ?? -1) ? 2 : 1)
                
                HStack {
                    ForEach(3..<6) { i in
                        PlayerView(scaled: self.highlighted == i, player: self.data.players[i])
                            .background(self.rectReader(index: i))
                    }
                }
                .zIndex((3..<6).contains(highlighted ?? -1) ? 2 : 1)
            }
        }
        
        func rectReader(index: Int) -> some View {
            return GeometryReader { (geometry) -> AnyView in
                if geometry.frame(in: .global).contains(self.location) {
                    DispatchQueue.main.async {
                        self.highlighted = index
                    }
                }
                return AnyView(Rectangle().fill(Color.clear))
            }
        }
    
        var body: some View {
            Content
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .updating($location) { (value, state, transaction) in
                    state = value.location
                }.onEnded {_ in
                    self.highlighted = nil
                })
        }
    }

