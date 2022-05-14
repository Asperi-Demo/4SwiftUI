A: The `shadowColor` is applied to default tab shadow which is currently absent, so we need a custom template image (eg. with gradient transparency) so `shadowColor` would tint it.

Here is working approach (Xcode 13.3 / iOS 15.4)

![BLdln](https://user-images.githubusercontent.com/62171579/168413806-59794781-6051-4626-a955-a23782ac457f.png)

	let appearance = UITabBarAppearance()
	appearance.shadowColor = .white
	appearance.shadowImage = UIImage(named: "tab-shadow")?.withRenderingMode(.alwaysTemplate)
	appearance.backgroundColor = UIColor.darkGray

	UITabBar.appearance().scrollEdgeAppearance = appearance

[Test module in project](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestTabBarShadow.swift)
