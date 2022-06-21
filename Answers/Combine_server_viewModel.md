```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Swift Combine Subscriptions, right flow and architectural choices (by MatterGoal)

A: I would do it with the following simple & manageable approach (IMO this is not the right place for "delegate"s).

Completely testable module: consumer is SwiftUI view. Tested as worked with Xcode 11.2 / iOS 13.2, however I don't see any platform limitations.

Demo:

![GjIIK](https://user-images.githubusercontent.com/62171579/174825475-616cbd0c-43d5-4ac4-b41f-b354794dd8a7.gif)

Here is a scratchy idea code. Please find additional comments inline.

    import SwiftUI
    import Combine
    
    protocol SocketServerManagerDelegate{
        func newEvent(event:String)
    }
    
    class SocketServerManager {
    
        // transparent subject that manages subscribers/subscriptions
        let publisher = PassthroughSubject<String, Never>()
    
        let timing: Double
        var timerHandler:Timer? = nil
    
        init(timing:Double){
            self.timing = timing
        }
    
        func start(){
            // Just start a timer that calls generateEvent to simulate some events
            timerHandler = Timer.scheduledTimer(withTimeInterval: timing, repeats: true){
                [weak self] _ in
                self?.generateEvent()
            }
            timerHandler?.fire()
        }
    
        func stop(){
            publisher.send(completion: .finished) // notifies all that finished
        }
    
        private func generateEvent(){
            let events = ["New Player", "Player Disconnected", "Server Error"]
            guard let currentEvent = events.randomElement() else { return }
    
            publisher.send(currentEvent) // send to all subscribers
        }
    }
    
    // usage
    class ViewModel: ObservableObject {
        private let server = SocketServerManager(timing: 1)
        private var cancellables = Set<AnyCancellable>()
    
        func setup() {
            guard cancellables.isEmpty else { return } // already set up
    
            // add one example subscriber
            server.publisher
                .assign(to: \.value1, on: self)
                .store(in: &cancellables)
    
            // add another example subscriber
            server.publisher
                .sink(receiveValue: { value in
                    self.value2 = value
                })
                .store(in: &cancellables)
    
            server.start()
        }
    
        @Published var value1: String = "<unknown>"
        @Published var value2: String = "<unknown>"
    }
    
    // view demo
    struct TestSocketServerPublisher: View {
        @ObservedObject var viewModel = ViewModel()
    
        var body: some View {
            VStack {
                Text("Observer1: \(viewModel.value1)")
                Divider()
                Text("Observer2: \(viewModel.value2)")
            }
            .onAppear {
                self.viewModel.setup()
            }
        }
    }
    
