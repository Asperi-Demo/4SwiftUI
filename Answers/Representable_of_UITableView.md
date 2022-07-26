```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: UITableView with UIViewRepresentable in SwiftUI (by Sorin Lica)

A: I assume this is due to corrupted reused table view cells... (and probably lost hosting controllers, because there where created on stack and not stored anywhere) 

Please find below corrected a bit your code with mentioned fixes. Tested & worked with Xcode 11.2 / iOS 13.2.

Here is code (with some comments inline):


    class HostingCell: UITableViewCell { // just to hold hosting controller
        var host: UIHostingController<AnyView>?
    }
    
    struct UIList: UIViewRepresentable {
    
        var rows: [String]
    
        func makeUIView(context: Context) -> UITableView {
            let collectionView = UITableView(frame: .zero, style: .plain)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.dataSource = context.coordinator
            collectionView.delegate = context.coordinator
            collectionView.register(HostingCell.self, forCellReuseIdentifier: "Cell")
            return collectionView
        }
    
        func updateUIView(_ uiView: UITableView, context: Context) {
        }
    
        func makeCoordinator() -> Coordinator {
            Coordinator(rows: rows)
        }
    
        class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
    
            var rows: [String]
    
            init(rows: [String]) {
                self.rows = rows
            }
    
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                self.rows.count
            }
    
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
                let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HostingCell
    
                let view = Text(rows[indexPath.row])
                        .frame(height: 50).background(Color.blue)
                
                // create & setup hosting controller only once
                if tableViewCell.host == nil {
                    let controller = UIHostingController(rootView: AnyView(view))
                    tableViewCell.host = controller
                    
                    let tableCellViewContent = controller.view!
                    tableCellViewContent.translatesAutoresizingMaskIntoConstraints = false
                    tableViewCell.contentView.addSubview(tableCellViewContent)
                    tableCellViewContent.topAnchor.constraint(equalTo: tableViewCell.contentView.topAnchor).isActive = true
                    tableCellViewContent.leftAnchor.constraint(equalTo: tableViewCell.contentView.leftAnchor).isActive = true
                    tableCellViewContent.bottomAnchor.constraint(equalTo: tableViewCell.contentView.bottomAnchor).isActive = true
                    tableCellViewContent.rightAnchor.constraint(equalTo: tableViewCell.contentView.rightAnchor).isActive = true
                } else {
                    // reused cell, so just set other SwiftUI root view
                    tableViewCell.host?.rootView = AnyView(view)
                }
                tableViewCell.setNeedsLayout()
                return tableViewCell
            }
        }
    }


Added demo code for just `UIList` itself - works fine with pro models as well. 

![EXwvs](https://user-images.githubusercontent.com/62171579/168430132-edfbf317-d357-49c5-a44c-98c5440191f6.gif)

    struct TestUIList: View {
        var body: some View {
            UIList(rows: generateRows())
        }
        
        func generateRows() -> [String] {
            (0..<100).reduce([]) { $0 + ["Row \($1)"] }
        }
    }

