
Q: How to remove List Separator lines in SwiftUI 2.0 in iOS 14 and above (Osama Naeem)

A: Here is a demo of possible solution. Tested with Xcode 12b.

![3FIOI](https://user-images.githubusercontent.com/62171579/163232791-2fbdea2b-a503-4ab9-9b9a-1724bf6767a7.png)


    List {
        ForEach(0..<3) { _ in
            VStack {
                Text("Hello, World!").padding(.leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .listRowInsets(EdgeInsets())
            .background(Color(UIColor.systemBackground)))
        }
    }

