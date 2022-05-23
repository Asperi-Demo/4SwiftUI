Q: Trying to present SwiftUI from HostingViewController with Enviroment Variable (by p0ny)

A: Here is the simplest variant I would use:

    class SavedListViewController: UIHostingController<AnyView> {
        required init?(coder: NSCoder) {
    
            let listView = SavedEventListView().environmentObject(RemindersViewModel())
            super.init(rootView: AnyView(listView))
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
        }
    }


**Update (Xcode 13.3)** now it seems I have better idea for that, at least strict type:

```
class SavedListViewController: UIHostingController<SavedListViewController.MyView> {

	struct MyView: View {
		var body: some View {
			SavedEventListView().environmentObject(RemindersViewModel())
		}
	}

	required init?(coder: NSCoder) {
		super.init(rootView: MyView())
	}

// ...
}
```
