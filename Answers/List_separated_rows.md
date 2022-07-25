```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How can I create a SwiftUI list with separated members, without using Section (by elixir)

A: A possible solution for this is to turn off default row background and separators and make row drawing by ourselves using row insets to manage distances between rows... and this will not break default List bahavior.

Tested with Xcode 13.4 / iOS 15.5

<img width="430" alt="Screenshot 2022-07-25 at 20 33 07" src="https://user-images.githubusercontent.com/62171579/180839218-7511546e-e281-4470-aa52-9c467f05c547.png">


            List {
                ForEach(["Stop", "russia", "NOW"], id: \.self) { item in
                    NavigationLink {
                        VStack {
                            Text("name \(item)")
                        }
                    } label: {
                        HStack {
                            Text(item)
                            Spacer()
                        }.font(.title)
                    }
                    .padding().foregroundColor(.white)
                }
                .background(RoundedRectangle(cornerRadius: 12).fill(.blue))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            }
            .listStyle(.insetGrouped)
