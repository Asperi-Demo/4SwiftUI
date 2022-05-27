```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I remove background Color from section in SwiftUI? (by Kyle)

A: Here is possible solution - use list row background color same to parent background.

Tested with Xcode 12.1 / iOS 14.1

![mLcPr](https://user-images.githubusercontent.com/62171579/170639943-55e8e965-130e-4d37-80c2-3355f550e677.png)

```
struct FormView: View {
    var body: some View {
        Form {
            Section {
                Button(action: {
                    
                }) {
                    HStack {
                        Spacer()
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .listRowInsets(.init())
                .listRowBackground(Color.red)     // << here !!
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(15)
            }
        }.background(Color.red).edgesIgnoringSafeArea(.all)
    }
}
```

When dealing with a non-solid color, add

```
            .onAppear {
               UITableViewCell.appearance().backgroundColor = UIColor.clear
            }
```

and set

```.listRowBackground(Color.clear)```
