//
//  WishListApp.swift
//  WishList
//
//  Created by olivier geiger on 02/04/2025.
//

import SwiftUI
import SwiftData

@main
struct WishListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: WishModel.self)
        }
    }
}
