```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Render Images on iOS 14 Widgets (by ilvthsgm)

A: Constucting timeline you need to specify explicit entry date for each entry. The policy parameter is for *recreating* next timeline.

So your `getTimeline` should look like

```
func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
	var entries: [ImageEntry] = []
	let currentDate = Date()

	for i in 1 ..< 4 {
		let imageNumber = String(i)
		let currentImage = "image_" + imageNumber
		let entryDate = Calendar.current.date(byAdding: .minute, value: (i-1)*5, to: currentDate)!
		let entry = ImageEntry(date: entryDate, image: currentImage)
		entries.append(entry)
	}

	let timeline = Timeline(entries: entries, policy: .atEnd)
	completion(timeline)
}
```
