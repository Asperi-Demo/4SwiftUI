```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Localizable.strings not working inside a List (by Alexander Farber)

A: Probably there is a bug for number formats, at least below works for strings.

	List($vm.currentGames, id: \.self) { $gameNumber in
		NavigationLink(
			destination: GameView(gameNumber: gameNumber)
		) {
			Text("game-number #\(String(gameNumber))")  // << here !!
		}
	}

with combination in `.strings`

```
"game-number #%@" = "Game #%@";
"game-number #%@" = "Spiel #%@";
"game-number #%@" = "Игра #%@";
```

Tested with Xcode 13 / iOS 15

![zRY7M](https://user-images.githubusercontent.com/62171579/174423268-b570c0a1-cd0c-4a75-9f2a-e70fcd6e1346.gif)
