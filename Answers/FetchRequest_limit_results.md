```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How to limit the number of results in a FetchRequest in SwiftUI (by simibac)

A: We can create SwiftUI `FetchRequest` with instance of CoreData `NSFeatchRequest` (configured 
according to our needs) using corresponding initialiser, as shown below:

    var fetchRequest:FetchRequest<Kana>
    init() {
        let request: NSFetchRequest<Kana> = Kana.fetchRequest()

        request.fetchLimit = 10            // << here !!
        request.predicate = NSPredicate(format: "alphabet == %@", "hiragana")

        fetchRequest = FetchRequest<Kana>(fetchRequest: request)  // << here !!
    }
