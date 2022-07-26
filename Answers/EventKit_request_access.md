```
🔥BOYCOTT on russia - terrorist must be punished!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: Requesting EventKit access macOS SwiftUI (by santi.gs)

A: We should not check status, but request access with EKEventStore().requestAccess(... directly, as documented

    /**
        @method     requestAccessToEntityType:completion:
        @discussion Users are able to grant or deny access to event and reminder data on a per-app basis. To request access to
                    event and/or reminder data, call -requestAccessToEntityType:completion:. This will not block the app while
                    the user is being asked to grant or deny access.
     
                    Until access has been granted for an entity type, the event store will not contain any calendars for that
                    entity type, and any attempt to save will fail. The user will only be prompted the first time access is
                    requested; any subsequent instantiations of EKEventStore will use the existing permissions. When the user
                    taps to grant or deny access, the completion handler will be called on an arbitrary queue.
    */
    @available(macOS 10.9, *)
    open func requestAccess(to entityType: EKEntityType, completion: @escaping EKEventStoreRequestAccessCompletionHandler)


so use the following

    func checkCalendarAuthorizationStatus() {

        eventStore.requestAccess(to: .event, completion:
          {(granted: Bool, error: Error?) -> Void in
              if granted {
                self.insertEvent(store: eventStore)
              } else {
                print("Access denied")
              }
        })
    }

and make sure `NSCalendarsUsageDescription` description is added in `Info.plist`.
