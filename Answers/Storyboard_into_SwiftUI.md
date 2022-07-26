```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to add Storyboard ViewController into SwiftUI Project? (by Najam)

A: It should not be just created controller by class initialiser, to instantiate it from 
storyboard one have to do like the following - in `makeUIViewController`:

```swift
struct AssetsListView: UIViewControllerRepresentable {

var taskID : String
public typealias UIViewControllerType = AssetsListViewController

func makeUIViewController(context: 
         UIViewControllerRepresentableContext<AssetsListView>) -> AssetsListViewController {
    let storyboard = UIStoryboard(name: "Main",     // < your storyboard name here
          bundle: nil)
    let assetsListVC = storyboard.instantiateViewController(identifier: 
          "AssetsListViewController")      // < your controller storyboard id here

    assetsListVC.taskID = taskID
    return assetsListVC

}
```
