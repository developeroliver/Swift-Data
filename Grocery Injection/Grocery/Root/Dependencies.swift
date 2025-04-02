//
//  Dependencies.swift
//  Grocery
//
//

import SwiftUI

/// Une structure qui regroupe toutes les dépendances de l'application.
@MainActor
struct Dependencies {

    /// Le conteneur de dépendances.
    let container: DependencyContainer

    /// Le gestionnaire des données.
    let dataManager: DataManager

    /// Initialise les dépendances en fonction de la configuration de build.
    ///
    /// - Parameter config: La configuration de build (mock, dev, prod).
    init(config: BuildConfiguration) {
        switch config {
        case .mock:
            /// Configuration pour les tests mock.
            dataManager = DataManager(
                service: SwiftDataDatasource(),
                local: MockLocalPersistance(mocks: DataModel.mocks)
            )
        case .dev:
            /// Configuration pour l'environnement de développement.
            dataManager = DataManager(service: SwiftDataDatasource())
        case .prod:
            /// Configuration pour l'environnement de production.
            dataManager = DataManager(service: SwiftDataDatasource())
        }

        /// Initialise le gestionnaire des notifications push.

        /// Crée un conteneur de dépendances et enregistre tous les services.
        let container = DependencyContainer()
        container.register(DataManager.self, service: dataManager)

        /// Assigne le conteneur de dépendances à la propriété `container`.
        self.container = container
    }
}

/// Extension de `View` pour configurer l'environnement de prévisualisation.
extension View {
    /// Configure l'environnement de prévisualisation avec des services mock.
    ///
    /// - Returns: La vue avec l'environnement configuré.
    func previewEnvironment() -> some View {
        self
            .environment(DevPreview.shared.container)
            .environment(
                DataManager(
                    service: SwiftDataDatasource(),
                    local: MockLocalPersistance(mocks: DataModel.mocks)
            )
        )
    }
}

/// Une classe singleton utilisée pour prévisualiser les dépendances en mode développement.
@MainActor
class DevPreview {

    /// L'instance partagée de `DevPreview`.
    static let shared = DevPreview()

    /// Le conteneur de dépendances.
    let container: DependencyContainer
    
    /// Le gestionnaire des données.
    let dataManager: DataManager

    /// Initialise `DevPreview` avec des services mock.
    init() {
        self.dataManager = DataManager(
            service: SwiftDataDatasource(),
            local: MockLocalPersistance(mocks: DataModel.mocks)
        )

        let container = DependencyContainer()
        container.register(DataManager.self, service: dataManager)
        self.container = container
    }
}
