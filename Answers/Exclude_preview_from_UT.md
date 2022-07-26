```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Exclude SwiftUI previews from code coverage? (by Qingwan Kuah)

A: Here is a description of working approach (demo with Xcode 13 / iOS 15):

1) Add explicit Testing (name as you want) configuration for UT

![LxWzj](https://user-images.githubusercontent.com/62171579/170641429-04ec6009-241d-4bf0-82b0-ea4fdd018a5f.png)

2) Add conditional macro TESTING (name as you want) for Testing configuration

![CqpF1](https://user-images.githubusercontent.com/62171579/170641457-1492c8e8-b36c-466e-b391-2176b8f01527.png)

3) Put preview provider into condition like

```
struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

#if !TESTING
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
```

4) Set Testing configuration for UT schema

![shsuf](https://user-images.githubusercontent.com/62171579/170641477-295bd419-9584-4292-bb66-e0599d008ca8.png)

5) Run UT and observe coverage

![MsuRK](https://user-images.githubusercontent.com/62171579/170641528-a226b84e-a1a2-4ba0-bc87-bbffc2e759a3.png)


