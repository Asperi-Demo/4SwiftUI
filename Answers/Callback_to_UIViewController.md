>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: How to go back from a SwiftUI View inside a to UIKit? (by Lucas Goldner)

A: The possible approach is to pass completion callback into your SwiftUI view, like in below simplified demo

```
struct WorkoutSelectView: View {
	var completion: () -> () = {}

	var body: some View {
		Button("Close", action: completion)
	}
}
```

and use this callback in your UIViewController to dismiss presented controller, like

```
@IBSegueAction func swiftUIAction(_ coder: NSCoder) -> UIViewController? {
   let controller =  UIHostingController(coder: coder, 
        rootView: WorkoutSelectView() { [weak self] in
           self?.dismiss(true)
        })
   return controller
}
```
