```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to open Share Sheet from presented sheet (by Patrick Michiels)

A: The problem is in trying to show second sheet from root controller. It already has one attached, so rejects another (which is Activity in this case).

The solution is to use own controller, placed in opened our sheet as a presenter for activity.

Here is a simple demo. Tested with Xcode 13 / iOS 15.

![riwMk](https://user-images.githubusercontent.com/62171579/173345202-a0dd4988-3189-40a2-8780-afaeaf24b2db.gif)

```
struct SheetView: View {

   @Binding var showSheetView: Bool
	@State private var isShare = false
   var body: some View {


      // Below share Sheet - now works!
      Button(action: {
			isShare = true    // present activity
      }) {
        Text("Share Me")
      }
      .background(SharingViewController(isPresenting: $isShare) {
         let url = URL(string: "https://apple.com")
         let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
         av.completionWithItemsHandler = { _, _, _, _ in
				isShare = false // required for re-open !!!
			}
			return av
		})
   }
}

struct SharingViewController: UIViewControllerRepresentable {
	@Binding var isPresenting: Bool
	var content: () -> UIViewController

	func makeUIViewController(context: Context) -> UIViewController {
		UIViewController()
	}

	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		if isPresenting {
			uiViewController.present(content(), animated: true, completion: nil)
		}
	}
}
```
