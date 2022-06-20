```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: CGContext not drawing after initialising (by Greg Price)

A: Here is a simple demo of creating offscreen content for preparing something (might be heavy, so not blocking UI) to present in view

![63yMX](https://user-images.githubusercontent.com/62171579/174598058-43a8e2ea-afe5-49b5-b0e5-1868fa22e049.png)

```swift
class ViewWithOffscreenDrawing: UIView {
    private var offscreenImage: CGImage? = nil

    override func draw(_ rect: CGRect) {
        if offscreenImage == nil { // image not ready
            DispatchQueue.global(qos: .background).async { // draw offscreen
                let image = renderSomething(of: rect.size)
                DispatchQueue.main.async { [weak self] in
                    self?.offscreenImage = image
                    self?.setNeedsDisplay()
                }
            }
            return
        }

        // image has prepared - just draw on screen
        UIGraphicsGetCurrentContext()?.draw(offscreenImage!, in: rect)
    }
}

func renderSomething(of size: CGSize) -> CGImage? {
    let bitsPerComponent = 8
    let bytesPerRow = Int(size.width) * 4
    let colorSpace = CGColorSpace(name: CGColorSpace.genericRGBLinear)!

    let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height),
        bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow,
        space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)

    // >>> draw anything heavy in background context

    context?.setFillColor(gray: 1, alpha: 1)
    context?.fill(CGRect(origin: .zero, size: size))
    context?.setFillColor(UIColor.red.cgColor)
    context?.fillEllipse(in: CGRect(origin: .zero, size: size))

    // <<<

    return context?.makeImage() // generated result
}
```
