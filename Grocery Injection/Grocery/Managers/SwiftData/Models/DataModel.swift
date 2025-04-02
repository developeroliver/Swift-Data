//
//  DataModel.swift
//  Grocery
//
//

import UIKit
import Foundation
import SwiftData

@Model
final class DataModel: Identifiable {

    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool = false) {
      self.title = title
      self.isCompleted = isCompleted
    }
    
    static var mock: DataModel {
        mocks[0]
    }

    static var mocks: [DataModel] {
        [
            DataModel(
                title: "Bakery & Bread",
                isCompleted: false
            ),
            DataModel(
                title: "Meat & Seafood",
                isCompleted: true
            ),
            DataModel(
                title: "Cereals",
                isCompleted: .random()
            ),
            DataModel(
                title: "Cheese & Eggs",
                isCompleted: .random()
            )
        ]
    }
}
