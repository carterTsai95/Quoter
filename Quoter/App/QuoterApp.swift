//
//  QuoterApp.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-16.
//

import SwiftUI

@main
struct QuoterApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
