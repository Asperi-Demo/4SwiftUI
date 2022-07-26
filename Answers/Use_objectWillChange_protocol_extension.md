```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: I'm trying to use "objectWillChange.send()" in an protocol extension but it's not working, any idea why? (by M.Serag)

protocol PlayerListStateProviding: ObservableObject {
    var players: [PlayerModel] { get set }
}

protocol PlayerListDeleting {
    var moc: NSManagedObjectContext { get set }
    func delete(at indexSet: IndexSet)
}

A: To use default observable object publisher in protocol you should limit it to corresponding type (because it is in extension to `ObservableObject`), as in

    extension PlayerListDeleting where Self: PlayerListStateProviding,  
                   Self.ObjectWillChangePublisher == ObservableObjectPublisher {
        func delete(at indexSet: IndexSet) {
            moc.delete(players.remove(at: indexSet.first!))
            objectWillChange.send()
        }
    }

