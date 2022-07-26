```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: How can I change to and from a NSPersistentCloudKitContainer when the user toggles "CloudSync"? (by ap123)

A: Here is possible approach - with dynamic key path and explicity observation of changes:

```
extension UserDefaults { // helper key path for observing
    @objc dynamic var useCloudSync: Bool {
        return bool(forKey: "useCloudSync")
    }
}

class CoreDataManager {
    static let sharedManager = CoreDataManager()

    private var observer: NSKeyValueObservation?
    private init() {
    }

    lazy var persistentContainer: NSPersistentContainer = {
        setupContainer()
    }()

    private func setupContainer() -> NSPersistentContainer {

        if nil == observer {
            // setup observe for defults changed
            observer = UserDefaults.standard.observe(\.useCloudSync) { [weak self] (_, _) in
                try? self?.persistentContainer.viewContext.save() // save anything pending
                if let newContainer = self?.setupContainer() {
                    self?.persistentContainer = newContainer
                }
            }
        }

        let useCloudSync = UserDefaults.standard.bool(forKey: "useCloudSync")

        let containerToUse: NSPersistentContainer?
        if useCloudSync {
            containerToUse = NSPersistentCloudKitContainer(name: "App")
        } else {
            containerToUse = NSPersistentContainer(name: "App")
            let description = containerToUse!.persistentStoreDescriptions.first
            description?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        }

        guard let container = containerToUse, let description = container.persistentStoreDescriptions.first else {
            fatalError("Hey Listen! ###\(#function): Failed to retrieve a persistent store description.")
        }
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        container.loadPersistentStores { (storeDescription, error) in
            //      ...
        }

        return container
    }
}
```
