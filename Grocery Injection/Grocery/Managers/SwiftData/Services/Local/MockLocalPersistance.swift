//
//  MockLocalPersistance.swift
//  Grocery
//

import Foundation

/// Pour la preview
class MockHomeInteractor: HomeInteractor {
    
    private var dataStorage: [DataModel] = DataModel.mocks

    func fetchData() -> [DataModel] {
        return dataStorage
    }
    
    func create(data: DataModel) {
        dataStorage.append(data)
    }
    
    func delete(data: DataModel) {
        if let index = dataStorage.firstIndex(where: { $0.id == data.id }) {
            dataStorage.remove(at: index)
        }
    }
}


class MockLocalPersistance: LocalPersistance {
    
    private var mocks: [DataModel]

    init(mocks: [DataModel] = DataModel.mocks) {
        self.mocks = mocks
    }

    func getAll() -> [DataModel] {
        return mocks
    }
    
    func addData(model: DataModel) {
        mocks.append(model)
    }
    
    func updateData(model: DataModel) {
        guard let index = mocks.firstIndex(of: model) else { return }
        mocks[index] = model
    }
    
    func save() {
//        UserDefaults.standard.setValue(try? JSONEncoder().encode(mocks), forKey: "MockLocalData")
    }
    
    func deleteData(model: DataModel) {
        mocks.removeAll { $0.id == model.id }
    }
    
    func deleteAllData() {
        mocks.removeAll()
    }
}
