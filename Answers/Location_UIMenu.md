```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Change the location of an UImenu in swift (by Ricardo Guerrero)

A: **iOS 14+**

Sinse iOS 14 `UIControl` has method that provides point to which attach a menu

    /// Return a point in this control's coordinate space to which to attach the given configuration's menu.
    @available(iOS 14.0, *)
    open func menuAttachmentPoint(for configuration: UIContextMenuConfiguration) -> CGPoint

so you can override `UIButton` to provide desired location for a menu (calculated or hardcoded) relatively to the button itself (`cause it is in button's coordinate space) and use that button either in storyboard (as a class for control) or created programmatically (if you need to inject it somewhere):

```
class MyButton: UIButton {
  var offset = CGPoint.zero
  override func menuAttachmentPoint(for configuration: UIContextMenuConfiguration) -> CGPoint {
    // hardcoded variant
//    return CGPoint(x: 0, y: -50)

    // or relative to orginal
    let original = super.menuAttachmentPoint(for: configuration)
    return CGPoint(x: original.x + offset.x, y: original.y + offset.y)
  }
}

class ViewController: UIViewController {

  @IBOutlet weak var btnMenuExtras: MyButton!   // << from storyboard

  override func viewDidLoad() {
    super.viewDidLoad()

    let menu = UIMenu(title: "", children: [
      UIAction(title: NSLocalizedString("Gallery", comment: ""), image: UIImage(systemName: "folder"), handler: {
        (_) in
//        self.loadPhotoGallery()
      })
    ])

        // offset is hardcoded for demo simplicity
    btnMenuExtras.offset = CGPoint(x: 0, y: -50)    // << here !!
    btnMenuExtras.menu = menu
  }
}
```
![tztA3](https://user-images.githubusercontent.com/62171579/171552276-08fc3be5-909d-4b18-a40e-b42a1b124a5b.png)

Result:

![Ofvy3](https://user-images.githubusercontent.com/62171579/171552305-0cfc0664-3fe0-4309-a270-93ae41f198ac.png)


Demo prepared & tested with Xcode 13 / iOS 15
