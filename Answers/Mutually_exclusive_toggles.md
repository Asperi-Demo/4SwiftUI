Q: How do I set a group of toggles to be mutually exclusive in swift (by IMKt)

A: Here is some alternate approach, which does not require to hardcode interdependently all bindings, but instead use shared storage of bools:

![UzjWV](https://user-images.githubusercontent.com/62171579/171708157-57613e8d-02b5-4b3b-b81c-ad1c419bec82.gif)

```
struct DemoExclusiveToggles: View {
    @State var flags = Array(repeating: false, count: 9)
    var body: some View {
        ScrollView {
            ForEach(flags.indices) { i in
                ToggleItem(storage: self.$flags, tag: i, label: "Switch \(i+1)")
                    .padding(.horizontal)
            }
        }
    }
}

struct ToggleItem: View {
    @Binding var storage: [Bool]
    var tag: Int
    var label: String = ""

    var body: some View {
        let isOn = Binding (get: { self.storage[self.tag] },
            set: { value in
                withAnimation {
                    self.storage = self.storage.enumerated().map { $0.0 == self.tag }
                }
            })
        return Toggle(label, isOn: isOn)
    }
}
```
