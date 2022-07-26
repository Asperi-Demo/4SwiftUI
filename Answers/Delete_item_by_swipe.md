```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Delete a item row from list - SwiftUI (by Milad)

    ForEach($taskVM.tasks) { $task in

A: If your `Task` is `Identifiable` (if not it worth making it), then you could  make delete action like

	.swipeActions(edge: .leading) {
		Button(role: .destructive){
			withAnimation {
				tasks.removeAll { task.id == $0.id }
			}
		} label: {
			Label("Delete", systemImage: "trash")
		}
	}

