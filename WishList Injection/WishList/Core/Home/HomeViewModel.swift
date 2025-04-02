//
//  HomeViewModel.swift
//  WishList
//
//  Created by olivier geiger on 02/04/2025.
//

import SwiftUI

@MainActor
protocol HomeInteractor {
    func fetchData() -> [DataModel]
    func create(data: DataModel)
    func delete(data: DataModel)
}

extension CoreInteractor: HomeInteractor { }

@Observable
@MainActor
class HomeViewModel {
    
    private let interactor: HomeInteractor
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
        loadData()
    }
    
    var datas: [DataModel] = []
    var textfieldText: String = ""
    var shouldClearFocus: Bool = false
    var sortType: SortType = .none
    var isAlertShowing: Bool = false
    
    var sortedDatas: [DataModel] {
        switch sortType {
        case .none:
            return datas
        case .name:
            return datas.sorted(by: { $0.title < $1.title })
        }
    }
    
    func loadData() {
        datas = interactor.fetchData()
    }
    
    func addNewItem() {
        guard !textfieldText.isEmpty else {
            return
        }
        
        let newItem = DataModel(title: textfieldText, isCompleted: false)
        interactor.create(data: newItem)
        loadData()
        textfieldText = ""
        shouldClearFocus = true
    }
    
    func resetFocusState() {
        shouldClearFocus = false
    }
    
    func onDelete(_ data: DataModel) {
        interactor.delete(data: data)
        loadData()
    }
}
