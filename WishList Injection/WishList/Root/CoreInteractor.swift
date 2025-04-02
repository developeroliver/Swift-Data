//
//  CoreInteractor.swift
//  WishList
//
//

import SwiftUI
/// Un interactor central qui coordonne les interactions entre les différents gestionnaires de l'application.
@MainActor
struct CoreInteractor {

    /// Le gestionnaire des données.
    private let dataManager: DataManager

    /// Initialise l'interactor avec un conteneur de dépendances.
    ///
    /// - Parameter container: Le conteneur de dépendances.
    init(container: DependencyContainer) {
        self.dataManager = container.resolve(DataManager.self)!
    }

    // MARK: DataManager

    /// Les données actuellement gérées par le gestionnaire de données.
    var datas: [DataModel] {
        dataManager.datas
    }

    /// Récupère les données actuellement gérées par le gestionnaire de données.
    ///
    /// - Returns: Une liste de modèles de données.
    func fetchData() -> [DataModel] {
        return dataManager.datas
    }

    /// Crée un nouveau modèle de données.
    ///
    /// - Parameter data: Le modèle de données à créer.
    func create(data: DataModel) {
        dataManager.addData(data: data)
    }

    /// Sauvegarde les données actuellement gérées par le gestionnaire de données.
    func save() {
        dataManager.save()
    }
    
    func update(data: DataModel) {
        dataManager.updateData(data: data)
    }

    /// Supprime un modèle de données.
    ///
    /// - Parameter data: Le modèle de données à supprimer.
    func delete(data: DataModel) {
        dataManager.deleteData(data: data)
    }

    /// Supprime toutes les données gérées par le gestionnaire de données.
    func deleteAllData() {
        dataManager.deleteAllData()
    }
}
