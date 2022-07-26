```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI Calling functions from other class (by Blaj Bogdan)

A: Depending on what your going to do in that call there are options, but 
actually it is any modifier that has closure argument, also `init`, ex:

**Option 1**

    struct ContentView: View {
    
        let variable = TempC()
        init() {
            variable.GetData()    // << here !!
        }
        var body: some View {
                Text("Hello World")
        }
    }


**Option 2**

    struct ContentView: View {
    
        let variable = TempC()
    
        var body: some View {
            Text("Hello World")
            .onTapGesture {
                self.variable.GetData()    // << here !!
            }
            .onAppear {
                self.variable.GetData()    // << here !!
            }
        }
    }

Similarly you can call it in `Button() { /* here */ }` or any other, pass reference to your class instance during initialising, etc.

**Note:** technically it is also possible in `body` but I would recommend to be very careful with that and do not perform any more
or less *heavy* calculations there, because it will affect UI responsibility for a user.
