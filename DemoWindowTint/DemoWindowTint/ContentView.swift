// DISCLAIMER: For DEMO purpose only. Created by Asperi on 14.03.2020.

import SwiftUI

struct ContentView: View {
    @Environment(\.hostingWindow) var hostingWindow

    @State private var isAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Go Link", destination:
                    Text("Keep coding!"))
                Divider()
                Button("Show Alert") {
                    self.isAlert = true
                }
            }
        }
        .alert(isPresented: $isAlert) {
            Alert(title: Text("Keep coding!"))
        }
        .onAppear {
                // can be loaded from UserDefaults here, and later changed on any action
                self.hostingWindow()?.tintColor = UIColor.red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
