```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Reusing a UITableView with different view model types (by LondonGuy)

A: Here is possible solution. Tested with Xcode 11.4 / iOS 13.4

If you move/duplicate all `UITablView` delegate/datasource callbacks into view model, then actually you don't need context coordinator at all, so generic entities can be as

```
// generic table view model protocol
protocol CustomTableViewModel: UITableViewDataSource, UITableViewDelegate {
    func configure(tableView: UITableView)
}

// generic table view that depends only on generic view model
struct CustomTableView<ViewModel:ObservableObject & CustomTableViewModel>: UIViewRepresentable {
    @ObservedObject var viewModel: ViewModel

    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        viewModel.configure(tableView: tableView)
        return tableView
    }

    func updateUIView(_ tableView: UITableView, context: Context) {
        tableView.reloadData()
    }
}
```

And here is example of usage

```
// some specific model
class MyViewModel: NSObject, ObservableObject, CustomTableViewModel {
    let items = ["one", "two", "three"]
    let cellIdentifier = "MyCell"

    func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }

    func numberOfRows(in section: Int) -> Int { 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

struct MyView: View {
    @EnvironmentObject var myViewModel: MyViewModel

    var body: some View {
        CustomTableView(viewModel: myViewModel)
    }
}
```

*Note: actually with next decomposition step it could be separation of `Presenter` concept from `ViewModel`, but for simplicity of demo for direction above should be enough.*
