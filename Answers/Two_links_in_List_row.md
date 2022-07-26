```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwitUI - Two navigationLink in a list (by BinaryBang)

A: Try the following approach - the idea is to hide links in background of visible content and make them inactive for UI, but activated programmatically. 

Tested with Xcode 12 / iOS 14.

```
struct MultiNavLink: View {

    var body: some View {
        return
            NavigationView {
                List {
                    OneRowView()
                }.navigationBarTitle("MultiNavLink", displayMode: .inline)
        }
    }
}

struct OneRowView: View {
    @State var mb_isActive1 = false
    @State var mb_isActive2 = false

    var body: some View {
        ZStack {
            Text("Single tap::go to destination1\nDouble tap,go to destination2")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .background(Group {
            NavigationLink(destination: Text("Destination1"), isActive: $mb_isActive1) {
                    EmptyView() }
                .buttonStyle(PlainButtonStyle())
            NavigationLink(destination: Text("Destination2"), isActive: $mb_isActive2) {
                    EmptyView() }
                .buttonStyle(PlainButtonStyle())
        }.disabled(true))
        .highPriorityGesture(TapGesture(count: 2).onEnded {
            self.mb_isActive2 = true
        })
        .onTapGesture(count: 1) {
            self.mb_isActive1 = true
        }
    }
}
```
