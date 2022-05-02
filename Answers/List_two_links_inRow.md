```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: SwiftUI MVVM Coordinator/Router/NavigationLink /or how to have two links in List row/ (by Darko)

A: It is better to use generics for your row, as below (tested with Xcode 11.4)

Usage example:

    ProductFamilyRow(item: ProductFamilyItem(title: "Test"),
        destinationView1: { Text("Details1") },
        destinationView2: { Text("Details2") })

Interface:

**Update** - added block for row highlight. List has auto detection for button or link inside row and highlights if any standard (!key) present. So, to disable such behaviour it needs to hide everything under custom button style.

```
struct ProductFamilyRowStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .colorMultiply(configuration.isPressed ? 
                 Color.white.opacity(0.5) : Color.white) // any effect you want
    }
}

struct ProductFamilyRow<D1: View, D2: View>: View {
    let item: ProductFamilyItem
    let destinationView1: () -> D1
    let destinationView2: () -> D2

    init(item: ProductFamilyItem, @ViewBuilder destinationView1: @escaping () -> D1,
        @ViewBuilder destinationView2: @escaping () -> D2)
    {
        self.item = item
        self.destinationView1 = destinationView1
        self.destinationView2 = destinationView2
    }

    @State private var selection: Int? = 0

    var body: some View {
        VStack {
            HStack {
                Text(item.title)
                Button(action: {
                    self.selection = 1
                }) {
                    Text("Destination 1")
                        .background( // hide link inside button !!
                            NavigationLink(destination: destinationView1(),
                                tag: 1, selection: self.$selection) { EmptyView() }
                        )
                }.foregroundColor(Color.blue)

                Button(action: {
                    self.selection = 2
                }) {
                    Text("Destination 2")
                        .background(
                            NavigationLink(destination: destinationView2(),
                                tag: 2, selection: self.$selection) { EmptyView() }
                        )
                }.foregroundColor(Color.blue)
            }

            //Image(item.image)
        }.frame(maxWidth: .infinity) // to have container centered
        .buttonStyle(ProductFamilyRowStyle())
    }
}
```
