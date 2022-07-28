// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

import SwiftUI

struct TestColorSelector: View {
    var body: some View {
        GradientView(name: "Test")
    }
    
    struct GradientView: View {
        let name: String
        @State private var redValue = 124.0
        @State private var greenValue = 124.0
        @State private var blueValue = 124.0
        @State private var selectedColor: CGColor = UIColor.green.cgColor
        @State var isEditing = false
        var body: some View {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        VStack {
                            Slider(value: $redValue,
                                   in: 0...255,
                                   step: 1
                            ).onChange(of: self.redValue, perform: { newValue in
                                self.sliderChanged()
                            })
                            .accentColor(.red)
                            Slider(value: $greenValue,
                                   in: 0...255,
                                   step: 1
                            ).onChange(of: self.greenValue, perform: { newValue in
                                self.sliderChanged()
                            })
                            .accentColor(.green)
                            
                            Slider(value: $blueValue,
                                   in: 0...255,
                                   step: 1
                            ).onChange(of: self.blueValue, perform: { newValue in
                                self.sliderChanged()
                            }).accentColor(.blue)
                        }
                        
                        VStack {
                            ColorView(selectedColor: $selectedColor)
                                .padding()
                            //.foregroundColor(.black)
                        }
                        //.background(selectedColor)//.background(Capsule().fill(selectedColor))
                        //.init(red: redValue, green: greenValue, blue: blueValue)
                    }
                }
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle(name)
        }
        
        func sliderChanged() {
            selectedColor = CGColor.init(red: CGFloat(redValue)/255, green: CGFloat(greenValue/255), blue: CGFloat(blueValue)/255, alpha: 1.0)
            print("Slider value changed to ")
            print("\(redValue):\(greenValue):\(blueValue)")
        }
    }
    
    
    struct ColorView: View {
        @Binding var selectedColor: CGColor
        
        var body: some View {
            
            let components: [CGFloat] = selectedColor.components ?? [0, 0, 0]
            Text("#\(String(format:"%02X", Int(components[0]*255)))\(String(format:"%02X", Int(components[1]*255)))\(String(format:"%02X", Int(components[2]*255)))")
                .padding()
                .background(Capsule().fill(Color(selectedColor)))
                .font(.system(.caption).bold())
        }
    }
    
}

struct TestColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        TestColorSelector()
    }
}
