//
//  WishModel.swift
//  WishList
//
//  Created by olivier geiger on 02/04/2025.
//

import Foundation
import SwiftData

@Model
class WishModel {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
