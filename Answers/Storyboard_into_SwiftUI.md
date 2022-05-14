```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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
