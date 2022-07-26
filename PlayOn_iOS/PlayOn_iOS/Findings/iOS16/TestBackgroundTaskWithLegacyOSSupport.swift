// 🔥BOYCOTT on russia - terrorist must be punished!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

#if false // disabled to avoid conflict with main App

import SwiftUI
import BackgroundTasks

struct AppScene: Scene {    // Legacy app scene
    @Environment(\.scenePhase) var scenePhase
   
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

@available(iOS 16, *)
struct RefreshingAppScene: Scene {   // New app scene
    
    @Environment(\.scenePhase) var scenePhase
   
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .backgroundTask(.appRefresh("refreshAllData")) {
            try? await Task.sleep(nanoseconds: 2_000_000) // just to be something for test
        }
    }
}


@main
struct AppLauncher {
    static func main() {
        if #available(iOS 16, *) { // << OS condition here !!
            New_iOSApp.main()
        } else {
            Old_iOSApp.main()
        }
    }
}

@available (iOS 16, *)
struct New_iOSApp: App {   // New app

    var body: some Scene {
        RefreshingAppScene()
    }
}

struct Old_iOSApp: App {   // Legacy app
    var body: some Scene {
        AppScene()
    }
}

#endif
