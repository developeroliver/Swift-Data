//
//  DependencyContainer.swift
//  Grocery
//
//

import SwiftUI

/// Un conteneur de dépendances qui permet d'enregistrer et de résoudre des services.
@Observable
@MainActor
class DependencyContainer {

    /// Un dictionnaire privé qui stocke les services enregistrés.
    private var services: [String: Any] = [:]

    /// Enregistre un service dans le conteneur.
    ///
    /// - Parameters:
    ///   - type: Le type du service à enregistrer.
    ///   - service: Une instance du service à enregistrer.
    func register<T>(_ type: T.Type, service: T) {
        let key = "\(type)"
        services[key] = service
    }

    /// Enregistre un service dans le conteneur en utilisant une fonction de création.
    ///
    /// - Parameters:
    ///   - type: Le type du service à enregistrer.
    ///   - service: Une fonction qui retourne une instance du service à enregistrer.
    func register<T>(_ type: T.Type, service: () -> T) {
        let key = "\(type)"
        services[key] = service()
    }

    /// Résout un service enregistré dans le conteneur.
    ///
    /// - Parameters:
    ///   - type: Le type du service à résoudre.
    /// - Returns: Une instance du service si elle est enregistrée, sinon `nil`.
    func resolve<T>(_ type: T.Type) -> T? {
        let key = "\(type)"
        return services[key] as? T
    }
}
