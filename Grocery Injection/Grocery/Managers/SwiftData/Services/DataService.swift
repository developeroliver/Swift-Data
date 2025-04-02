//
//  DataService.swift
//  Grocery
//
//

import Foundation

protocol DataService {
    func getAll() -> [DataModel]
    func addData(model: DataModel)
    func save()
    func updateData(model: DataModel)
    func deleteData(model: DataModel)
    func deleteAllData()
}
