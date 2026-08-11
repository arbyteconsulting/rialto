import SwiftUI

@main
struct RialtoApp: App {
    @Environment(\.openWindow) private var openWindow

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.titleBar)
        .windowToolbarStyle(.unified(showsTitle: false))
        .defaultSize(width: 1000, height: 680)
        .commands {
            CommandGroup(replacing: .newItem) {}
            CommandGroup(replacing: .appInfo) {
                Button("About Rialto") {
                    openWindow(id: "about")
                }
            }
        }

        Window("About Rialto", id: "about") {
            AboutView()
        }
        .windowResizability(.contentSize)
    }
}
