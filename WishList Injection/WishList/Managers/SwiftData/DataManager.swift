//
//  DataManager.swift
//  WishList
//
//

import SwiftUI

@Observable
class DataManager {
    
    private let service: SwiftDataDatasource
    private let local: LocalPersistance

    /// it's like getAll(type: DataModel)
    var datas: [DataModel] = []

    init(
        service: SwiftDataDatasource = SwiftDataDatasource(),
        local: LocalPersistance = MockLocalPersistance()
    ) {
        self.service = service
        self.local = local
        loadData()
    }

    func loadData() {
        let localData = local.getAll()
        let serviceData = service.getAll(type: DataModel.self)
        #if MOCK
        datas = localData.isEmpty ? serviceData : localData
        print("Loaded mock data: \(datas.count) items")
        #else
        datas = serviceData
        #endif
    }

    func addData(data: DataModel) {
        #if MOCK
        local.addData(model: data)
        local.save()
        #else
        service.addData(model: data)
        service.save()
        #endif
        loadData()
    }
    
    func save() {
        service.save()
        loadData()
    }
    
    func updateData(data: DataModel) {
        #if MOCK
        local.updateData(model: data)
        local.save()
        #else
        service.updateData(model: data)
        service.save()
        #endif
        loadData()
    }
    
    func deleteData(data: DataModel) {
        service.deleteData(model: data)
        loadData()
    }
    
    func deleteAllData() {
        datas.removeAll()
        service.deleteAllData(type: DataModel.self)
    }
}
