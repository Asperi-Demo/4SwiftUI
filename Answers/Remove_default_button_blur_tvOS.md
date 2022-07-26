```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: UIKit - How to prevent default blur and focus background of UITextField? (by Tr1et)

A: Actually we always can inherit UIKit classes and do whatever layout/style we want. Here is very raw demo of how this can be done.

Prepared & tested with Xcode 12.1 / tvOS 14.0

![0J0qN](https://user-images.githubusercontent.com/62171579/174435862-c4d48cd5-58e4-4c18-b6ce-d326a7fffdf6.png)

![1NIba](https://user-images.githubusercontent.com/62171579/174435868-db05dc81-4316-4ab6-8049-dfbd000e5630.png)


So just substitute custom subclass of UITextField class

![WDeqw](https://user-images.githubusercontent.com/62171579/174435872-b7bf0ca3-c50a-44de-9122-f6c7ce6211cd.png)


```
class MyTextField: UITextField {

	lazy var textLayer = CATextLayer()
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		layer.backgroundColor = UIColor.clear.cgColor

		textLayer.font = self.font
		textLayer.fontSize = 36
		textLayer.foregroundColor = UIColor.white.cgColor
		textLayer.alignmentMode = .center
		textLayer.frame = layer.bounds
		layer.addSublayer(textLayer)
		layer.borderWidth = 2
	}

	override func layoutSublayers(of layer: CALayer) {
		layer.borderColor = self.isFocused ? UIColor.black.cgColor : UIColor.clear.cgColor
		textLayer.frame = layer.bounds
		textLayer.string = self.text?.isEmpty ?? true ? self.placeholder : self.text
	}

	override func addSubview(_ view: UIView) {
		// blocks standard styling
	}

}
```
