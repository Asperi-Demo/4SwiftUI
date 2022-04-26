```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Get array item with an IndexSet (by Oswaldo Gallo)

A: Taking into account that mentioned `deleteRequest` semantically is asynchronous and there might be, in general, several contacts deleted in one user action, I would do it like below

    func delete(at offsets: IndexSet) {

        // preserve all ids to be deleted to avoid indices confusing
        let idsToDelete = offsets.map { self.contacts[$0].id }

        // schedule remote delete for selected ids
        _ = idsToDelete.compactMap { [weak self] id in
            self?.deleteRequest(id){ success in
                if success {
                    DispatchQueue.main.async {
                        // update on main queue
                        self?.contacts.removeAll { $0.id == id }
                    }
                }
            }
        }
    }

*Note: also some feedback in UI would be needed marking progressed contacts and disabling user from other manipulations with them till end of corresponding `deleteRequest`*
