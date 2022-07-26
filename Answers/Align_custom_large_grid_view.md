```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI How to align a view that's larger than screen width (by berkabbasoglu)

A: Here is a demo of possible approach (and direction of improvements, because I did not test all cases and possibilities)

*Note: if you select only one `ScrollView` axis it does content alignment automatically, otherwise it is now I assume confused, but does not have capability to be configured. So below might be considered as temporary workaround.*

The idea is to read grid content offset via `GeometryReader` recalculation of frame in `.global.` coordinate space and mitigate it explicitly.

Also there is a try to invalidate and handle offset depending on device orientation (probably not ideal, but as a first try), because they are different.

![ttlIK](https://user-images.githubusercontent.com/62171579/179004630-a762da2a-c830-4a09-bdce-69a153a8d381.png)
![a4ii2](https://user-images.githubusercontent.com/62171579/179004645-33390b9a-0d51-4cde-b2f3-0299ff444d43.png)


    import Combine
    
    struct TableView: View {
        let columnCount: Int = 9
        let rowCount: Int = 14
    
        @State private var offset: CGFloat = .zero
    
        private let orientationPublisher = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                ScrollView([.horizontal, .vertical], showsIndicators: false) {
                    GridStack(rows: self.rowCount, columns: self.columnCount) { row, col in
                        Text("ROW \(String(row)) COL \(String(col))")
                            .fixedSize()
                            .frame(width: 150)
                    }
                    .background(rectReader())
                    .offset(x: offset)
                }
            }
            .onReceive(orientationPublisher) { _ in
                self.offset = .zero
            }
        }
    
        func rectReader() -> some View {
            return GeometryReader { (geometry) -> AnyView in
                let offset = -geometry.frame(in: .global).minX
                if self.offset == .zero {
                    DispatchQueue.main.async {
                        self.offset = offset
                    }
                }
                return AnyView(Rectangle().fill(Color.clear))
            }
        }
    }

