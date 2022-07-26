```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI List with SidebarListStyle does not have Rounded Corners? (by christophriepe)

A: For that you need different style

	 List {
		  Label("Option", systemImage: "list.bullet.rectangle")
		  Label("Option", systemImage: "tv")
		  Label("Option", systemImage: "mail.stack")
	 }
	 .listStyle(InsetGroupedListStyle())

![VA4Nl](https://user-images.githubusercontent.com/62171579/168441232-13b9bd49-80d7-4742-95f8-7c757577505d.png)


**Update:** using conditional list style

		NavigationView {
			 List {
				  Label("Option", systemImage: "list.bullet.rectangle")
				  Label("Option", systemImage: "tv")
				  Label("Option", systemImage: "mail.stack")
			 }
			 .sidebarStyle(if: UIDevice.current.userInterfaceIdiom == .pad)
			 .navigationTitle("Options")
		}

and helper extension

```
extension List {
    @ViewBuilder
    func sidebarStyle(if flag: Bool) -> some View {
        if flag {
            self.listStyle(SidebarListStyle())
        } else {
            self.listStyle(InsetGroupedListStyle())
        }
    }
}
```
