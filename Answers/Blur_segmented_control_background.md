```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How to blur the background of a segmented control? (by user784637)

A: Here is possible approach... the idea is to place blur-effect view behind the segmented control in some wrapper view and provide that view as header for table.

Here is demo (how it looks with just some my settings, but those are all configurable), of course gif is not very good for this, but it is visible that blur effect works.

![D4Nes](https://user-images.githubusercontent.com/62171579/174816962-d6f9c799-56e0-4b1b-9a0e-a870168671ea.gif)

Approach demo code:

    class HeaderView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
    
            let blurEffect = UIBlurEffect(style: .dark) // .light looks better as for me, so used in demo
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.translatesAutoresizingMaskIntoConstraints = false
    
            let items = ["First", "Second"]
            let customSC = UISegmentedControl(items: items)
            customSC.selectedSegmentIndex = 0
            customSC.translatesAutoresizingMaskIntoConstraints = false
    
            self.addSubview(customSC)
            customSC.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            customSC.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            customSC.widthAnchor.constraint(equalToConstant: 200).isActive = true
            customSC.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
            self.insertSubview(blurEffectView, belowSubview: customSC)
            blurEffectView.leadingAnchor.constraint(equalTo: customSC.leadingAnchor).isActive = true
            blurEffectView.trailingAnchor.constraint(equalTo: customSC.trailingAnchor).isActive = true
            blurEffectView.topAnchor.constraint(equalTo: customSC.topAnchor).isActive = true
            blurEffectView.bottomAnchor.constraint(equalTo: customSC.bottomAnchor).isActive = true
            blurEffectView.layer.cornerRadius = 8
            blurEffectView.layer.masksToBounds = true
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

