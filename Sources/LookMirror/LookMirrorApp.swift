import SwiftUI

@main
struct LookMirrorApp: App {
    var body: some Scene {
        MenuBarExtra("LookMirror", systemImage: "mustache.fill") {
            ContentView()
        }
        .menuBarExtraStyle(.window)
    }
}
