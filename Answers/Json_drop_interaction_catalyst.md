```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Receive JSON file in DropInteraction in iOS app running in Mac Catalyst (by Blake Barrett)

```
extension SentimentViewController: UIDropInteractionDelegate {
    
    static let JSONTypeIdentifier = "public.json"
```

A: You don't need URL, because drop item already has item provider for JSON data, so it is just needed to extract that data from `NSItemProvider` and decode.

Here is fixed parts (tested with Xcode 12.1)

	func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
		session.items.forEach { item in
			guard item.itemProvider.hasItemConformingToTypeIdentifier(SentimentViewController.JSONTypeIdentifier) else { return }
			item.itemProvider.loadDataRepresentation(forTypeIdentifier: SentimentViewController.JSONTypeIdentifier) { data, error in
				if let data = data {
					self.importJSONData(from: data)
				}
			}
		}
	}
    
    private func importJSONData(from data: Data) {
        print("Decode JSON from \(data.description).")
    }


