```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Get blank view before the printer selection (by Russ)

A: Here is fixed variant. The main point is that `UIPrintInteractionController` shows own sheet, so it is not needed for it, and `updateUIViewController` is for different purpose - update content on external data change, so all preparations should be made in `makeUIViewController`.

*Note: `UIMarkupTextPrintFormatter` reference should be kept in properties otherwise it is lost and result in crash on print sheet close.* 

Tested with Xcode 12 / iOS 14

![B2uvE](https://user-images.githubusercontent.com/62171579/175801220-df108af9-9e9f-41f3-a2dd-85b5d74f3f0e.gif)

```
struct PrintHTMLView: UIViewControllerRepresentable
{
    let title: String
    let formatter: UIMarkupTextPrintFormatter
    let callback: () -> ()

    init(htmlString: String, title: String, completion: @escaping () -> () = {}) {
        self.title = title
        self.callback = completion

        formatter = UIMarkupTextPrintFormatter(markupText: htmlString)
        formatter.perPageContentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
    }

    func makeUIViewController(context: Context) -> UIViewController
    {
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = title
        printInfo.outputType = .general

        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.showsNumberOfCopies = true

        printController.printFormatter = formatter

        let controller = UIViewController()
        DispatchQueue.main.async {
            printController.present(animated: true, completionHandler: { _, _, _ in
                printController.printFormatter = nil
                self.callback()
            })
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context)
    {
    }
}

struct TestPrintController: View {
    @State private var printShowing = false
    var body: some View {
        Button("Print")
        {
            self.printShowing = true
        }
        .background(Group {
            if self.printShowing {
                PrintHTMLView(htmlString: "Test String", title: "Report") {
                    self.printShowing = false
                }
            }
        })

    }
}
```
