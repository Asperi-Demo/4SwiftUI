>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Combine framework serialize async operations (by matt)

A: Here is one page playground code that depicts possible approach. The main idea is to transform async API calls into chain of `Future` publishers, thus making serial pipeline.

Input: range of int from 1 to 10 that asynchrounosly on background queue converted into strings

**Demo of direct call to async API:**

    let group = DispatchGroup()
    inputValues.map {
        group.enter()
        asyncCall(input: $0) { (output, _) in
            print(">> \(output), in \(Thread.current)")
            group.leave()
        }
    }
    group.wait()

Output:

>     >> 1, in <NSThread: 0x7fe76264fff0>{number = 4, name = (null)}
>     >> 3, in <NSThread: 0x7fe762446b90>{number = 3, name = (null)}
>     >> 5, in <NSThread: 0x7fe7624461f0>{number = 5, name = (null)}
>     >> 6, in <NSThread: 0x7fe762461ce0>{number = 6, name = (null)}
>     >> 10, in <NSThread: 0x7fe76246a7b0>{number = 7, name = (null)}
>     >> 4, in <NSThread: 0x7fe764c37d30>{number = 8, name = (null)}
>     >> 7, in <NSThread: 0x7fe764c37cb0>{number = 9, name = (null)}
>     >> 8, in <NSThread: 0x7fe76246b540>{number = 10, name = (null)}
>     >> 9, in <NSThread: 0x7fe7625164b0>{number = 11, name = (null)}
>     >> 2, in <NSThread: 0x7fe764c37f50>{number = 12, name = (null)}

**Demo of combine pipeline:**

Output:

>     >> got 1
>     >> got 2
>     >> got 3
>     >> got 4
>     >> got 5
>     >> got 6
>     >> got 7
>     >> got 8
>     >> got 9
>     >> got 10
>     >>>> finished with true


Code:

    import Cocoa
    import Combine
    import PlaygroundSupport
    
    // Assuming there is some Asynchronous API with
    // (eg. process Int input value during some time and generates String result)
    func asyncCall(input: Int, completion: @escaping (String, Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
                sleep(.random(in: 1...5)) // wait for random Async API output
                completion("\(input)", nil)
            }
    }
    
    // There are some input values to be processed serially
    let inputValues = Array(1...10)
    
    // Prepare one pipeline item based on Future, which trasform Async -> Sync
    func makeFuture(input: Int) -> AnyPublisher<Bool, Error> {
        Future<String, Error> { promise in
            asyncCall(input: input) { (value, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(value))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .map {
            print(">> got \($0)") // << sideeffect of pipeline item
            return true
        }
        .eraseToAnyPublisher()
    }
    
    // Create pipeline trasnforming input values into chain of Future publishers
    var subscribers = Set<AnyCancellable>()
    let pipeline =
        inputValues
        .reduce(nil as AnyPublisher<Bool, Error>?) { (chain, value) in
            if let chain = chain {
                return chain.flatMap { _ in
                    makeFuture(input: value)
                }.eraseToAnyPublisher()
            } else {
                return makeFuture(input: value)
            }
        }
    
    // Execute pipeline
    pipeline?
        .sink(receiveCompletion: { _ in
            // << do something on completion if needed
        }) { output in
            print(">>>> finished with \(output)")
        }
        .store(in: &subscribers)
    
    PlaygroundPage.current.needsIndefiniteExecution = true
