```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: Get previous CTFrame object from given text position with CoreText (by Igor Prusyazhnyuk)

A: The `CTFramesetter` does not manage list of `CTFrame`, and the frames themselves are immutable. 

The frames management are on our responsibility, so if there are any changes in text source, ie. attributed string, we have to *re-generate* all frames from start, because this is the only way how framesetter progresses - there is no reverse-progressing mode. Fortunately this process is proved fast and can be done in background thread.

In the case it is just needed to have a frame (eg. offscreen drawing, etc.) for text range previous to current position (if, eg., from current position is drawn on screen), that frame can be created using like the following extension

```
extension CTFramesetter {
    func prevFrame(position: Int) -> CTFrame {

        let size = CTFramesetterSuggestFrameSizeWithConstraints(self,
            CFRange(location: 0, length: position), nil,
            CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude), nil)

        let path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        return CTFramesetterCreateFrame(self, CFRangeMake(0, position), path, nil)
    }
}
```

of course it is not generic, because layout paths can differ, and attributes can differ, but for simplified conditions as provided in topic started question it can be used.

