>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI Tabbar disappears when List touches Tabbar (by hoeeeeeh)

A: A possible approach is to construct appearance explicitly with all states needed (so be sure everything is activated and not conflicting with others), like

    init() {
    	let appearance = UITabBarAppearance()
    	appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.orange


		let itemAppearance = UITabBarItemAppearance(style: .stacked)
		itemAppearance.normal.iconColor = UIColor.white
		itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
		appearance.stackedLayoutAppearance = itemAppearance

		UITabBar.appearance().scrollEdgeAppearance = appearance
		UITabBar.appearance().standardAppearance = appearance
	}

Tested with Xcode 13.4 / iOS 15.5

![FTCbI](https://user-images.githubusercontent.com/62171579/184524291-f99c5183-e3df-486d-9730-59ee1c1ee3a1.gif)
