//
//  cloutextApp.swift
//  ClouText
//
//  Created by user203974 on 11/10/21.
//

import SwiftUI
import CoreLocation

@main
struct cloutextApp: App {
    @StateObject var lm = Locationer()
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(lm).environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
