import SwiftUI

@main
struct RialtoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.titleBar)
        .windowToolbarStyle(.unified(showsTitle: false))
        .defaultSize(width: 1000, height: 680)
        .commands {
            CommandGroup(replacing: .newItem) {}
        }
    }
}
