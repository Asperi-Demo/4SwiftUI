>
> 🔥BOYCOTT on russia - terrorist must be punished!<br>
> «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
> 
> ATTENTION: This is a demo - use it as you wish. Reference is appriciated.<br>
> If you want to thank - buy me coffee: [Coffee for Asperi](https://secure.wayforpay.com/donate/asperi)
>

Q: Can I perform a networking task when ScenePhase changes to .background? (by Zorgan)

A: In observer for scene phase we can specify that we have long-running task, so system will give app more time to finish

```swift
    @State private var taskIdentifier = UIBackgroundTaskIdentifier.invalid

    // ... other code
    .onChange(of: scenePhase) { phase in
        switch phase {
        case .background:

            taskIdentifier = UIApplication.shared.beginBackgroundTask { _ in
              // do this clean up due to time expired
            }
            guard taskIdentifier != .invalid else { return }

            // run your async task and in completion notify end background task
            run_some_API_task(completion: {
                if taskIdentifier != .invalid {
                  UIApplication.shared.endBackgroundTask(taskIdentifier)
                  taskIdentifier = .invalid
                }
            }) 

            default:
                print(">> do something else")
        }
    }
```

See here for more details https://developer.apple.com/documentation/backgroundtasks/choosing_background_strategies_for_your_app
