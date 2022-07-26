```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Clip image with semi-circle mask? (by TruMan1)

A: We can create own shape. Below is a simple demo variant (for square content).

```
private struct DemoClipShape: Shape {
	func path(in rect: CGRect) -> Path {
		Path {
			$0.move(to: CGPoint.zero)
			$0.addLine(to: CGPoint(x: rect.maxX, y: 0))
			$0.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
			$0.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.midY, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
			$0.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.midY, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
			$0.addLine(to: CGPoint.zero)
		}
	}
}
```

![QWsBQ](https://user-images.githubusercontent.com/62171579/178131140-591483cf-7a68-403b-9eae-e1f6b643b793.png)

And here is a sample of how it could be applied - due to padding we need to offset clipping (mask) to compensate locations (also it can be passed as constant into shape constructor, which will be more correct and accurate, but I leave it for you):

```
// used larger values for better visibility
Circle()
    .fill(Color.blue)
    .frame(width: 148, height: 148)
    .padding(.top, 18)
    .padding(.bottom, 10)
    .overlay(
        Image("product-sample1")
            .resizable()
            .scaledToFit()
    )
	.mask(DemoClipShape().offset(x: 0, y: -11))    // << here !!
```

gives

![9EZZP](https://user-images.githubusercontent.com/62171579/178131143-c53a8747-9e00-45ef-93a2-73e2e0bdbc1a.png)
