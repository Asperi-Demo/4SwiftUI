```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Get status of cancellation of my subscription in Combine iOS (by BilalReffas)

A: It is possible via handling events

```swift
subject
    .handleEvents(receiveCancel: {
        print(">> cancelled")         // << here !!
    })
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            print("Failed with: \(error.localizedDescription)")
        case .finished:
            print("Finished")
        }
    }) { string in
        print(string)
    }.store(in: &disposeBag)
```
