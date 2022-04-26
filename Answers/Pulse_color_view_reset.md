Q: Pulsating Animation & Change Colour (by )

A: You change the color, but animating view, which is set up *forever* is not changed - it 
remains as set and continues as specified - forever. So it needs to re-set the animation.

Please find below a working full module demo code (tested with Xcode 11.2 / iOS 13.2). 
The idea is to use `ObservableObject` view model as it allows and refresh view and 
perform some actions on receive. So receiving color changes it is possible to reset 
and view color and animation.

### Updated for Xcode 13.3 / iOS 15.4 ###

![ezgif com-gif-maker-42](https://user-images.githubusercontent.com/62171579/165232070-3de71bdb-48ad-420c-bc0f-43cdfdb51a4e.gif)

Main part is:

    @State var animate = false
    var body: some View {
      VStack {
        ZStack {
          Circle().fill(colourToShow().opacity(0.25)).frame(width: 40, height: 40).scaleEffect(self.animate ? 1 : 0)
          Circle().fill(colourToShow().opacity(0.35)).frame(width: 30, height: 30).scaleEffect(self.animate ? 1 : 0)
          Circle().fill(colourToShow().opacity(0.45)).frame(width: 15, height: 15).scaleEffect(self.animate ? 1 : 0)
          Circle().fill(colourToShow()).frame(width: 16.25, height: 16.25)
        }
        .onAppear { self.animate = true }
        .animation(animate ? Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default, value: animate)
        .onChange(of: viewModel.colorIndex) { _ in
          self.animate = false
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animate = true
          }
        }
      }
    }

[Test module in project is here](https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestPulseColorView.swift)
