//
//  Tip.swift
//  GroceryApp
//
//  Created by olivier geiger on 02/04/2025.
//

import Foundation
import TipKit

struct ButtonTip: Tip {
  var title: Text = Text("Essential Foods")
  var message: Text? = Text("Add some everyday items to the shopping list.")
  var image: Image? = Image(systemName: "info.circle")
}
