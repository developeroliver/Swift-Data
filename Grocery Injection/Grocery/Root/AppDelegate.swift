//
//  AppDelegate.swift
//  Grocery
//
//  Created by olivier geiger on 01/04/2025.
//

import Foundation
import UIKit

/// Le délégué de l'application qui configure les services et les dépendances au lancement.
class AppDelegate: NSObject, UIApplicationDelegate {

    /// Les dépendances de l'application.
    var dependencies: Dependencies!

    /// Méthode appelée lorsque l'application a terminé son lancement.
    ///
    /// - Parameters:
    ///   - application: L'application qui a terminé son lancement.
    ///   - launchOptions: Les options de lancement de l'application.
    /// - Returns: `true` si l'application a terminé son lancement, sinon `false`.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        let config: BuildConfiguration

        // Détermine la configuration de build en fonction des flags de compilation.
#if MOCK
        config = .mock
#elseif DEV
        config = .dev
#else
        config = .prod
#endif

        // Configure les services en fonction de la configuration de build.
        config.configure()

        // Initialise les dépendances de l'application.
        dependencies = Dependencies(config: config)

        return true
    }
}

/// Les configurations de build possibles pour l'application.
enum BuildConfiguration {
    /// Configuration mock pour les tests.
    case mock

    /// Configuration de développement.
    case dev

    /// Configuration de production.
    case prod

    /// Configure les services en fonction de la configuration de build.
    func configure() {
        switch self {
        case .mock:
            /// La configuration mock n'exécute pas Firebase.
            break
        case .dev:
            /// Configure Firebase pour l'environnement de développement.
            break
        case .prod:
            /// Configure Firebase pour l'environnement de production
            break
        }
    }
}
