```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Binding ViewModel and TextFields with SwiftUI (by MatterGoal)

A: Having view model with optional properties (which is often required or
not controlled by us because provided by API) does not allow to use it directly
with `TextField`, but it is possible to bind them dynamically.

Here is possible approach. Tested with Xcode 11.2/iOS 13.2


    class SignInViewModel: ObservableObject{
    
        @Published var username:String? = nil
        @Published var password:String? = nil
    }
    
    
    struct SigninView: View {
        @ObservedObject var viewModel = SignInViewModel()
    
        var body: some View {
            VStack(alignment: .leading, spacing: 15.0){
    
                TextField("username", text: Binding<String>(
                    get: {self.viewModel.username ?? ""},
                    set: {self.viewModel.username = $0}))
                TextField("password", text: Binding<String>(
                    get: {self.viewModel.password ?? ""},
                    set: {self.viewModel.password = $0}))
    
                Spacer()
    
                Button("Sign In"){
                    print("User: \(self.viewModel.username)")
                    print("Pass: \(self.viewModel.password)")
                }
            }.padding()
        }
    }

