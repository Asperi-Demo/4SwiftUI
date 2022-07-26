```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: ObservedObject view-model is still in memory after the view is dismissed (by swifty)

A: > Moreover, I noticed that if I to a change in ContetView and the view is reevaluated, then I will have two ViewModels in memory

It is due to cross-reference in `ViewModel`, here is fixed variant

```
struct OtherView: View, Constructable {

    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            TextField("Something", text: $viewModel.enteredText)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                print("Tap")
            }) {
                Text("Tapping")
            }.disabled(!viewModel.isValid)
        }
        .onDisappear {
            self.viewModel.invalidate()     // << here !!
        }
    }
}

class ViewModel: ObservableObject {

    @Published var enteredText = ""
    var isValid = false

    var cancellable: AnyCancellable?

    init() {
        print("[>>] created")
        cancellable = textValidatedPublisher.receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
    }

    func invalidate() {
        cancellable?.cancel()
        cancellable = nil
        print("[<<] invalidated")
    }

    deinit {
//        cancellable?.cancel()     // not here !!!
        print("[x] done")
    }

    var textValidatedPublisher: AnyPublisher<Bool, Never> {
        $enteredText.map {
            $0.count > 1
        }.eraseToAnyPublisher()
    }
}
```

--

**Update:**

> is there a way to instantiate OtherView when navigating?

Here is a solution (tested with Xcode 11.4 / iOS 13.4), but this is only half-a-deal, because once created it will be alive until navigation link revalidated (ie. on back it remains in memory until next navigate)

```
struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: 
               // create wrapper view with type of view which creation
               // is deferred until navigation
               DeferCreatingView(of: OtherView.self)) {
                Text("Press Here")
            }
        }
    }
}

protocol Constructable {
    init()
}

struct DeferCreatingView<T: View & Constructable>: View {
    var ViewType: T.Type

    init(of type: T.Type) {
        ViewType = type
    }

    var body: some View {
        ViewType.init()     // << create only here
    }
}


struct OtherView: View, Constructable {
    // .. not changed code from first part
}
```
