```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: ProgressBar iOS 13 (by Bram)

A: Progress is-a NSObject, it is not a struct, so state does not work for it. You have to use KVO to observe changes in Progress and redirect into SwiftUI view's source of truth.

Here is a simplified demo of possible solution. Tested with Xcode 12.1 / iOS 14.1

![neRN3](https://user-images.githubusercontent.com/62171579/171988005-bba71a26-528e-4aaa-9936-306bbff79e09.gif)

```
class ProgressBarViewModel: ObservableObject {
  @Published var fractionCompleted: Double
  let progress: Progress
  private var observer: NSKeyValueObservation!
  
  init(_ progress: Progress) {
    self.progress = progress
    self.fractionCompleted = progress.fractionCompleted
    observer = progress.observe(\.completedUnitCount) { [weak self] (sender, _) in
      self?.fractionCompleted = sender.fractionCompleted
    }
  }
}

struct ProgressBar: View {
  @ObservedObject private var vm: ProgressBarViewModel
  
  init(_ progress: Progress) {
    self.vm = ProgressBarViewModel(progress)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("\(Int(vm.fractionCompleted * 100))% completed")
      ZStack {
        RoundedRectangle(cornerRadius: 2)
          .foregroundColor(Color(UIColor.systemGray5))
          .frame(height: 4)
        GeometryReader { metrics in
          RoundedRectangle(cornerRadius: 2)
            .foregroundColor(.blue)
            .frame(width: metrics.size.width * CGFloat(vm.fractionCompleted))
        }
      }.frame(height: 4)
      Text("\(vm.progress.completedUnitCount) of \(vm.progress.totalUnitCount)")
        .font(.footnote)
        .foregroundColor(.gray)
    }
  }
}
```

and updated call place to use same constructor

```
struct ContentView: View {
    @State private var progress = Progress(totalUnitCount: 10)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            ProgressBar(progress)      // << here !!

// ... other code
```
