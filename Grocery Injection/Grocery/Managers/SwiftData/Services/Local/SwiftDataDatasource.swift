//
//  SwiftDataDatasource.swift
//  Grocery
//
//

import SwiftData

/// Une classe de gestion des opérations de données à l'aide de SwiftData.
class SwiftDataDatasource {
    
    /// Conteneur de modèle pour gérer les entités persistantes.
    private var modelContainer: ModelContainer
    
    /// Contexte de modèle pour interagir avec la base de données.
    private lazy var modelContext: ModelContext = {
        return ModelContext(modelContainer)
    }()
    
    /// Initialisation de la classe, configurant le conteneur de modèle.
    init() {
        do {
            self.modelContainer = try ModelContainer(
                for: DataModel.self // Ajoutez ici d'autres types de modèles si nécessaire
            )
        } catch {
            fatalError("Erreur lors de l'initialisation du ModelContainer: \(error.localizedDescription)")
        }
    }
    
    /// Récupère tous les objets d'un type donné depuis le conteneur de modèle.
    ///
    /// - Parameter type: Le type d'entité persistante à récupérer.
    /// - Returns: Un tableau d'objets du type demandé, ou un tableau vide en cas d'erreur.
    func getAll<T: PersistentModel>(type: T.Type) -> [T] {
        do {
            let fetchDescriptor = FetchDescriptor<T>(sortBy: [])
            return try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Erreur lors de la récupération des données : \(error.localizedDescription)")
            return []
        }
    }
    
    /// Crée et insère un nouvel objet dans le conteneur de modèle.
    ///
    /// - Parameter model: L'objet à insérer dans la base de données.
    func addData<T: PersistentModel>(model: T) {
        modelContext.insert(model)
        save()
    }
    
    /// Sauvegarde les modifications dans le conteneur de modèle.
    func save() {
        do {
            try modelContext.save()
        } catch {
            print("Erreur lors de la sauvegarde des modifications : \(error.localizedDescription)")
        }
    }
    
    /// Met à jour un objet existant dans le conteneur de modèle.
    ///
    /// - Parameters:
    ///   - model: L'objet à mettre à jour.
    ///   - updateBlock: Un bloc de fermeture qui permet de modifier les propriétés de l'objet.

    func updateData<T: PersistentModel>(model: T) {
            save()
        }
    
    /// Supprime un objet existant du conteneur de modèle.
    ///
    /// - Parameter model: L'objet à supprimer.
    func deleteData<T: PersistentModel>(model: T) {
        modelContext.delete(model)
        save()
    }
    
    /// Supprime toutes les données du conteneur de modèle.
    func deleteAllData<T: PersistentModel>(type: T.Type) {
        let allData = getAll(type: type)
        for data in allData {
            modelContext.delete(data)
        }
        save()
    }
}
