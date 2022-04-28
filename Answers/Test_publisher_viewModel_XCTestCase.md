```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How do I properly test a var that changes through a publisher in my viewModel in XCTestCase (by user1302387)

A: The reason is that view model asynchronous but test is synchronous...

    $username
      .receive(on: RunLoop.main)

... the `.receive` operator here makes final assignment of `isValid` on the next event cycle of `RunLoop.main`

but the test

    model.username = "1234"
    XCTAssertTrue(model.isValid) //<----- THIS FAILS HERE

expects that `isValid` will be changed immediately.

So there are following possible solutions:

1) remove `.receive` operator at all (in this case it is preferable, because it is UI workflow, which is anyway always on main runloop, so using scheduled receive is redundant. 

       $username
           .removeDuplicates()
           .map { input in
               print("~~~> \(input.count >= 3)")
               return input.count >= 3
           }
       .assign(to: \.isValid, on: self)
       .store(in: &disposables)

Result: 

    model.username = "1234"
    XCTAssertTrue(model.isValid) // << PASSED

2) make UT wait for one event and only then test `isValid` (in this case it should be documented that `isValid` has asynchronous nature by intention)

       model.username = "1234"
       RunLoop.main.run(mode: .default, before: .distantPast) // << wait one event
       XCTAssertTrue(model.isValid) // << PASSED


