```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Crash (SIGABRT) when writing data to UserDefaults after Sheet disappears (by L3n95)

![Screenshot 2022-06-18 at 08 06 11](https://user-images.githubusercontent.com/62171579/174423649-0d1c4fef-1273-43c8-a9f2-6bf6af20303f.png)

A: Let's analyze

        Button(action: {
            self.dismissAction = changeCounter       1)
            self.item = nil                          2)
        }, label: {

Line 1) changes internal sheet state initiating update of sheet's view
Line 2) changes external state initiating close of sheet (and probably update of parent view).

It even sounds as two conflicting process (even if there are no dependent flows, but looking at your code second depends on result of first). So, this is very dangerous logic and should be avoided.

In general, as I wrote in comment, changing two states in one closure is always risky, so I would rewrite logic to have something like (sketch):

    Button(action: {
        self.result = changeCounter  // one external binding !!
    }, label: {

, ie. the one state change that initiates some external activity...

Possible workaround for your code (if for any reason you cannot change logic) is to separate changes of those states in time, like

    Button(action: {
        self.dismissAction = changeCounter // updates sheet
        DispatchQueue.main.async {         // or after some min delay
          self.item = nil                  // closes sheet after (!) update
        }
    }, label: {

