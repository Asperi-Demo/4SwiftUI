// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestCustomToolbarItemFitFrame: View {
    var body: some View {
        ContentView()
    }

    struct ContentView: View {
        let size = 45.0
        let fontSize = 17.0
        
        var body: some View {
            NavigationView {
                Button { } label: {
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: size, height: size)
                .border(.yellow)
                .toolbar {
                    HStack(alignment: .top) {
                        
                        Button { print(">> action here")} label: {
                            Image(systemName: "globe")
                                .resizable()
                                .scaledToFill()
                        }
                        .buttonStyle(MyTabbarButtonStyle())
                        .frame(width: size, height: size)
                        .border(.red)
                        
                        // Image and Title
                        VStack {
                            Image("nemo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: size)
                            Text("Navigation Title")
                                .font(.system(size: fontSize))
                                .bold()
                        }.border(.green)
                    }
                }
            }
        }
    }

    struct MyTabbarButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(configuration.isPressed ? .gray : .blue)
        }
    }
}

struct TestCustomToolbarItemFitFrame_Previews: PreviewProvider {
    static var previews: some View {
        TestCustomToolbarItemFitFrame()
    }
}
