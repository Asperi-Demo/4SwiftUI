```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Combine: Publisher like Future but with multiple values (by Paul T.)

A: Here is possible alternate approach. No needs in `Defer`, `cause subject lives idle, and can send (pass-through) as many values as `libraryObject` will live.

Tested with Xcode 11.4.

```
var resultsPublisher: AnyPublisher<[Result], Error> {
    let subject = PassthroughSubject<[Result], Error>()
    libraryObject.listenToEvents { results, error in // called multiple times
        guard let results = results else {
            subject.send(completion: .failure(error))
            return
        }

        subject.send(results)
    }
    return subject.eraseToAnyPublisher()
}
```
