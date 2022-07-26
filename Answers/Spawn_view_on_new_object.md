```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Programmatically spawn view after core data item add (by Stephen)

A: Here is possible approach - the idea is to use dynamic binding to state property of newly created object and activate hidden navigation link programmatically.

Tested with Xcode 12.1 / iOS 14.1

	@State private var newObject: Object?
	private var isNewObject: Binding<Bool> {
		Binding(get: { self.newObject != nil },  // activate when state is set
		set: { _ in self.newObject = nil })      // reset back
	}

    ...

    List {

      Button(action: {
           addObject()
        }, label: { Image(systemName: "plus") })

      // List of existing objects, with a button to open ObjectEditor
      // and pass in the corresponding object for editing.

    }
    .background(
      NavigationLink(     
           destination: ObjectEditor(object: newObject),
           isActive: isNewObject,       // << activated programmatically !!
           label: { EmptyView() })
    )

    ...

    func addObject() {
        withAnimation {
            let newObject = Object(context: viewContext)
            newObject.title = "New Object"

            if let _ = try? viewContext.save() {
              self.newObject = newObject          // << here !!
            }
        }
    }
