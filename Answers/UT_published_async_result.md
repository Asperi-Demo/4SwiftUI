>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI Combine - How to test waiting for a publisher's async result (by Ryan)

A: You need to wait asynchronously via expectation and check result via publisher.

Here is possible approach. Tested with Xcode 13.2 / iOS 15.2

```
private var cancelables = Set<AnyCancellable>()
  func testContentViewModel() {
    // Given
    let viewModel = ContentViewModel()

    let expect = expectation(description: "results")
    viewModel.$results
            .dropFirst()     // << skip initial value !!
            .sink {
                XCTAssertEqual($0, ["01", "02", "03"])
                expect.fulfill()
            }
            .store(in: &cancelables)

    viewModel.searchText = "123"
    wait(for: [expect], timeout: 3)
}
```

![akVvn](https://user-images.githubusercontent.com/62171579/181316181-bda7fb4c-0f64-4197-9de8-ee23277ce036.png)

