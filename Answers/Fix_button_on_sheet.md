```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI - in sheet have a fixed continue button that is not scrollable (by ItsZiaW)

A: Here is a demo of possible approach (tuning & effects are out of scope - try to make demo code short). The idea is to inject `UIView` holder with button *above* sheet so it persist during sheet drag down (because as findings shown any dynamic offsets gives some ugly undesired shaking effects).

Tested with Xcode 12 / iOS 14

![xGPUk](https://user-images.githubusercontent.com/62171579/173339968-a6b0de11-63b5-429b-a9c7-25e7759da0db.gif)

```
            // ... your above sheet code here

            }//VStack for 3 criterias
            .padding([.leading, .trailing], 20)

                Spacer()

             // button moved from here into below background view !!

        }.background(BottomView(presentation: presentationMode) {
            Button {
                presentationMode.wrappedValue.dismiss()
                UserDefaults.standard.set(true, forKey: "LaunchedBefore")
            } label: {
                Text("Continue")
                    .fontWeight(.medium)
                    .padding([.top, .bottom], 15)
                    .padding([.leading, .trailing], 90)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
        })
        //Main VStack
    }
}

struct BottomView<Content: View>: UIViewRepresentable {
    @Binding var presentationMode: PresentationMode
    private var content: () -> Content

    init(presentation: Binding<PresentationMode>, @ViewBuilder _ content: @escaping () -> Content) {
        _presentationMode = presentation
        self.content = content
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView()

        DispatchQueue.main.async {
            if let window = view.window {
                let holder = UIView()
                context.coordinator.holder = holder

                // simple demo background to make it visible
                holder.layer.backgroundColor = UIColor.gray.withAlphaComponent(0.5).cgColor

                holder.translatesAutoresizingMaskIntoConstraints = false

                window.addSubview(holder)
                holder.heightAnchor.constraint(equalToConstant: 140).isActive = true
                holder.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 0).isActive = true
                holder.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 0).isActive = true
                holder.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: 0).isActive = true

                if let contentView = UIHostingController(rootView: content()).view {
                    contentView.backgroundColor = UIColor.clear
                    contentView.translatesAutoresizingMaskIntoConstraints = false
                    holder.addSubview(contentView)

                    contentView.topAnchor.constraint(equalTo: holder.topAnchor, constant: 0).isActive = true
                    contentView.bottomAnchor.constraint(equalTo: holder.bottomAnchor, constant: 0).isActive = true
                    contentView.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 0).isActive = true
                    contentView.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant: 0).isActive = true
                }
            }
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if !presentationMode.isPresented {
            context.coordinator.holder.removeFromSuperview()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var holder: UIView!

        deinit {
            holder.removeFromSuperview()
        }
    }
}
```
