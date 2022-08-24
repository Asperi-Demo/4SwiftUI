>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI: How to get .serif (New York) font in NavBarTitle (by Mike Z)

A: Not native way for now, but we still can use `appearance`. Here is a demo of possible solution. Tested with Xcode 12 / iOS 14

![u0Nyw](https://user-images.githubusercontent.com/62171579/186383719-c411794d-f725-4e44-be7f-a49ce46f38de.png)

	init() {
		UINavigationBar.appearance().largeTitleTextAttributes = 
           [.font: UIFont(descriptor: 
                   UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
                   .withDesign(.serif)!, size: 48)]
	}
	
    var body: some View {
		NavigationView {
			VStack {

                 // ...

			}.navigationTitle("New York")
		}

