```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to observe shared app groups file changed (by Dim)

A: Here is a simple demo of approach based on usage `NSFileCoordinator/NSFilePresenter` pattern.

Tested with Xcode 11.4 / iOS 13.4

1) Application part. Here is a `ViewController` plays a file presenter role, for simplicity (if one controller can manage many files, then it is better to create explicit presenters per-file)

```
class ViewController: UIViewController, NSFilePresenter {
    var presentedItemURL: URL?
    var presentedItemOperationQueue: OperationQueue = OperationQueue.main


    @IBOutlet weak var userNameField: UILabel!

    func presentedItemDidChange() { // posted on changed existed file only
        readFromFile()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // register for presentedItemDidChange work 
        NSFileCoordinator.addFilePresenter(self) 
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // unregister - required !!
        NSFileCoordinator.removeFilePresenter(self) 
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let file = "file.txt"
        let dir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.test.apps")!
        presentedItemURL = dir.appendingPathComponent(file)

        readFromFile() // read previously stored data
    }

    private func readFromFile()
    {
        let coordinator = NSFileCoordinator(filePresenter: self)
        coordinator.coordinate(readingItemAt: presentedItemURL!, options: [], error: nil) { url in
            if let text2 = try? String(contentsOf: url, encoding: .utf8) {
                userNameField.text = text2 // demo label in view for test
            } else {
                userNameField.text = "<no text>"
                //just initial creation of file needed to observe following changes
                coordinator.coordinate(writingItemAt: presentedItemURL!, options: .forReplacing, error: nil) { url in
                    do {
                        try "".write(to: url, atomically: false, encoding: .utf8)
                    }
                    catch { print("writing failed") }
                }
            }
        }
    }
}
```

2) Extension part (simple Today extension for demo having one button)

```
class TodayViewController: UIViewController, NCWidgetProviding, NSFilePresenter {
    var presentedItemURL: URL?
    var presentedItemOperationQueue: OperationQueue = OperationQueue.main

    override func viewDidLoad() {
        super.viewDidLoad()

        let file = "file.txt"
        let dir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.test.apps")!
        presentedItemURL = dir.appendingPathComponent(file)
    }
        
    @IBAction func post(_ sender: Any) { // action on button in extension
        writeToFile()
    }

    func writeToFile()
    {
        let text = "new data" //just a text
        let coordinator = NSFileCoordinator(filePresenter: self)
        coordinator.coordinate(writingItemAt: presentedItemURL!, options: .forReplacing, error: nil) { url in
            do {
                try text.write(to: url, atomically: false, encoding: .utf8)
            }
            catch { print("writing failed") }
        }
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
}
```
