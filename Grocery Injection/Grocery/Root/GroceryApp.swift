//
//  GroceryApp.swift
//  Grocery
//
//

import SwiftUI

/// Le point d'entrée principal de l'application
@main
struct GroceryApp: App {
    
    /// Le délégué de l'application UIKit, utilisé pour gérer les événements du cycle de vie de l'application.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(interactor: CoreInteractor(container: delegate.dependencies.container)))
                .environment(delegate.dependencies.container)
                .environment(delegate.dependencies.dataManager)
        }
    }
}
