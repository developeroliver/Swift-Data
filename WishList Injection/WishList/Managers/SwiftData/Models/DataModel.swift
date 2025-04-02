//
//  DataModel.swift
//  WishList
//
//

import UIKit
import Foundation
import SwiftData

@Model
final class DataModel: Identifiable {

    var title: String
    
    init(title: String, isCompleted: Bool = false) {
      self.title = title
    }
    
    static var mock: DataModel {
        mocks[0]
    }

    static var mocks: [DataModel] {
        [
            DataModel(
                title: "Master SwiftData"
            ),
            DataModel(
                title: "Master SwiftUI"
            ),
            DataModel(
                title: "Master Dependency Injection"
            ),
            DataModel(
                title: "Master Core Data"
            )
        ]
    }
}
