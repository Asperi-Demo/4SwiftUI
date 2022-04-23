```
BOYCOTT on ᵣussia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: How do I initialize an observedObject using an environmentobject as a parameter? (by Snarik)

A: A real object is injected into `EnvironmentObject` wrapper *after* view is created, ie. initialized, so
a possible and looks simplest approach is to separate `ObservedObject`-dependent part into dedicated (can be
private) view and inject/create observable view model inside `body`, like

    struct MyCoolView: View {
        @EnvironmentObject var userData: UserData
    
        var body: some View {
            MyCoolInternalView(ViewObject(id: self.userData.UID))
        }
    }
    
    struct MyCoolInternalView: View {
        @EnvironmentObject var userData: UserData
        @ObservedObject var viewObject: ViewObject
    
        init(_ viewObject: ViewObject) {
            self.viewObject = viewObject
        }
    
        var body: some View {
                Text("\(self.viewObject.myCoolProperty)")
        }
    }

