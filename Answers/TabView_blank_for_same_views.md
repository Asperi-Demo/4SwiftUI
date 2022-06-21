```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Why does TabView shows blank screen if two views are the same? (by Adrian Le Roy Devezin)

A: Just an idea - top level container view relies on uniquencess of content identity. So, assuming that your environment object for second 
view is correct, try to to make those to views really unique by using `.id` modifier, like below

```swift
TabView {
    EventsScreen().environmentObject(EventsViewModel(repo: IncentivesRespository()))
        .id(1)                    // << here !!
        .tabItem {
            Text("Barter")
            Image("icon_barter")
    }
    EventsScreen().environmentObject(EventsViewModel(repo: OpportunityRepository()))
        .id(2)                    // << here !!
        .tabItem {
            Text("Earn")
            Image("icon_earn")
    }
    ...
```

**Note:** I see usage `.navigationBarHidden(true)` in `AppView` - if it means you are going to include `TabView` into `NavigationView`, then **don't do that** - you won't have it work. TabView is designed to be **root view only**. If you need navigation place it *inside* tabs.
