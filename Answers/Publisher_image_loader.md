```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: URLSessionDataTask has no member 'map' Swift 5 (by Hunter)

A: We have to use `dataTaskPublisher` for that purpose not `dataTask` itself

    final class ImageLoader {
        
        private let cache = ImageCache()
        
        func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
            if let image = cache[url] {
                return Just(image).eraseToAnyPublisher()
            }
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .catch { error in return Just(nil) }
                .handleEvents(receiveOutput: {[unowned self] image in
                    guard let image = image else { return }
                    self.cache[url] = image
                })
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }

