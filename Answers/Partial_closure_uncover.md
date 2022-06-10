```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: What is Partial apply for closure#1 in Swift (by Deepak Sharma)

A: @DanielKaplan

> I am looking for an answer to the TITLE (as is the OP), not the cause
> of the stack trace. The answer must explain what "partial apply for
> closure#1" means.

A bit of background (from [here][1], for more deep [in math][2]):

[![enter image description here][3]][3]

So what's going on with?

    sessionQueue.async { [unowned self] in
        self.configureSession()
    }

Here we have closure calls function directly, swift compiler recognises this and makes currying, ie. instead of call function of function, unwraps closure and injects into `async` direct call of internal function, like

```
sessionQueue.async(execute: CapturePipeline.configureSession(self))
```

but to join this with source code debug info should preserve information about this simplification, so they mark it as *partial apply for closure#<N>* (where N is just ordered number of existed closures in parent function).

And to fix that crash as said before *the best* is to remove that part from `init` at all and call after creation completed. The worse, but depending on other code might be applicable, is to use `[weak self]`.

  [1]: https://books.google.com.ua/books?id=I1ozCwAAQBAJ&pg=PT152&lpg=PT152&dq=swift%20partial%20apply%20for%20closure&source=bl&ots=ASHmuQ3ZKi&sig=ACfU3U1QitZ-pWOIOWo8-MRC7voi4UoNiw&hl=en&sa=X&ved=2ahUKEwitnJaRpIn1AhUg_7sIHQpfBTkQ6AF6BAgcEAM#v=onepage&q=swift%20partial%20apply%20for%20closure&f=false
  [2]: https://en.wikipedia.org/wiki/Currying
  [3]: https://i.stack.imgur.com/yT29R.png
