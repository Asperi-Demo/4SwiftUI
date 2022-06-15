```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Animating a CAShapeLayer along an oval UIBezierPath (by Harold)

```
let ovalPath = UIBezierPath(ovalIn: CGRect(x: -25, y: -50, width: 50, height: 100))
ovalPath.apply(CGAffineTransform(rotationAngle: 45 * .pi / 180))
ovalPath.apply(CGAffineTransform(translationX: frame.size.width / 2, y: frame.size.height / 2))
with it's ShapeLayer:

let ovalLayer = CAShapeLayer()
ovalLayer.strokeColor = UIColor.lightGray.cgColor
ovalLayer.fillColor = UIColor.clear.cgColor
ovalLayer.path = ovalPath.cgPath
view.layer.addSublayer(ovalLayer)
That shows the oval path, tilted 45 degrees. This is how I set the animation:

let objectPath = UIBezierPath(arcCenter: CGPoint(x: 0 ,y: 0), radius: 50, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
let objectLayer = CAShapeLayer()
objectLayer.path = objectPath.cgPath
objectLayer.strokeColor = UIColor.darkGray.cgColor
objectLayer.fillColor = UIColor.darkGray.cgColor
view.layer.addSublayer(objectLayer)
objectLayer.add(animation, forKey: nil)
```

A: Here is a solution (jump is just gif animation end). Tested with Xcode 11.4 / iOS 13.4

![pWg8p](https://user-images.githubusercontent.com/62171579/173739662-84f2631b-e563-41f7-94e2-733cf6ba1606.gif)


```swift
let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
animation.duration = 5
animation.repeatCount = .greatestFiniteMagnitude // just recommended by Apple
animation.path = ovalPath.cgPath
animation.calculationMode = .paced    // << required !!
```
