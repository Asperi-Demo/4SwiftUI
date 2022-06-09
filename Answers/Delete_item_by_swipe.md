```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
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

