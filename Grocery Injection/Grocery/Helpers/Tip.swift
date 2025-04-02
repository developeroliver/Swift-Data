//
//  Tip.swift
//  Grocery
//
//

import Foundation
import TipKit

struct ButtonTip: Tip {
  var title: Text = Text("Trier")
  var message: Text? = Text("Vous pouvez effectuez un tri.")
  var image: Image? = Image(systemName: "info.circle")
}
