//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by olivier geiger on 02/04/2025.
//

import SwiftUI
import SwiftData

@main
struct GroceryAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
