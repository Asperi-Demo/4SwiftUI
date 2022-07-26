```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to present a UICollectionView in SwiftUI with UIViewControllerRepresentable (by Simon)

A: Here is minimal runnable demo. (*Note: Cell have to be registered if all is done programmatically*)

![sFSds](https://user-images.githubusercontent.com/62171579/176171666-4b43f1d1-31f0-42d6-a211-2ee0da1fc744.png)

```
class MyCell: UICollectionViewCell {
}

struct CollectionView: UIViewRepresentable {
    func makeUIView(context: Context) -> UICollectionView {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.clear
        view.dataSource = context.coordinator

        view.register(MyCell.self, forCellWithReuseIdentifier: "myCell")
        return view
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            3
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCell
            cell.backgroundColor = UIColor.red
            return cell
        }
    }
}
```
