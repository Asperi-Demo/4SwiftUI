```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Dismiss button in SwiftUI modal called from UIKit (by Hekes Pekes)

A: Here is a demo of possible approach. Tested with Xcode 11.4 / Playground

![6d2PJ](https://user-images.githubusercontent.com/62171579/167773813-dedcc33f-e76b-48cf-8587-f3b9a4b60279.gif)

Complete playground code:

```
import UIKit
import SwiftUI
import PlaygroundSupport

class ViewModel {
    var closeAction: () -> Void = {}
}

struct ModalView: View {
    var vm: ViewModel

    var body: some View {
        VStack {
            Text("I'm SwfitUI")
            Button("CloseMe") {
                self.vm.closeAction()
            }
        }
    }
}

class MyViewController : UIViewController {

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let button = UIButton(type: .roundedRect)
        button.setTitle("ShowIt", for: .normal)
        button.addTarget(self, action: #selector(MyViewController.showModal(_:)), for: .touchDown)

        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.view = view
    }

    @objc func showModal(_ : Any?) {
        let bridge = ViewModel()
        let vc = UIHostingController(rootView: ModalView(vm: bridge))
        bridge.closeAction = { [weak vc] in
            vc?.dismiss(animated: true)
        }
        self.present(vc, animated: true, completion: nil)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
```
