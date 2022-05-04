Q: How to perform an action after NavigationLink is tapped? (by mallow)

    NavigationLink(destination: TransactionsDetailsView()) {
    }
    .simultaneousGesture(TapGesture().onEnded{
    })


A: `NavigationLink` does not allow such simultaneous gestures (might be as designed, might be due to issue, whatever).

The behavior that is expected might be implemented as follows (of course if one needs some chevron in the list item, then it should be added manually)


    struct TestSimultaneousGesture: View {
        @State var showPlusButton = false
        @State var currentTag: Int?
        var body: some View {

            NavigationView {
                List {
                    ForEach(0 ..< 12) { item in
                        VStack {
                            HStack(alignment: .top) {
                                Text("List item")
                                NavigationLink(destination: Text("Details"), tag: item, selection: self.$currentTag) {
                                    EmptyView()
                                }
                            }
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .foregroundColor(.black)
                            Divider()
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                            print("Got Tap")
                            self.currentTag = item
                            self.showPlusButton = false
                        })
                        .simultaneousGesture(LongPressGesture().onEnded{_ in
                            print("Got Long Press")
                            self.currentTag = item
                            self.showPlusButton = false
                        })
                        .onAppear(){
                            self.showPlusButton = true
                        }
                    }
                }
            }
        }
    }

