>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: SwiftUI matchedGeometry + LazyVStack = crash (by Markon)

A: The problem is that you destroy `ScrollView` breaking matched layout. 

Here is fixed variant. Tested with Xcode 12 / iOS 14

![5HTsD](https://user-images.githubusercontent.com/62171579/182016746-9dfbb7a3-53b8-480e-bf7d-82c47f83ddb2.gif)

```
struct ContentView: View {
    @Namespace var namespace
    @State var selected: Int?


    var body: some View {
        ZStack {
            VStack {
                Text("Cool rectangles")
                
				  ScrollView(.vertical, showsIndicators: false) {
						BoxList(namespace: namespace, selected: $selected)
				  }.opacity(selected == nil ? 1 : 0)
            } // << or place here opacity modifier here
            
            if let id = selected {
                Rectangle()
                    .foregroundColor(.red)
                    .matchedGeometryEffect(id: id, in: namespace)
                    .onTapGesture {
                        withAnimation{
                            selected = nil
                        }
                    }

            }

        }
    }
}

struct BoxList: View {
    let namespace: Namespace.ID
    @Binding var selected: Int?
    
    var body: some View {
        LazyVStack {
            ForEach(0..<10){ item in
					if item == selected {
                Color.clear     // placeholder to avoid duplicate match id run-time warning
                    .frame(width: 200, height: 200)
					} else {
                Rectangle()
                    .matchedGeometryEffect(id: item, in: namespace)
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        withAnimation {
                            selected = item
                        }
                    }
						}
            }
        }
    }
}
```
