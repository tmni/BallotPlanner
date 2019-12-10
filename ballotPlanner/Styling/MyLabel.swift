//
//  MyLabel.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/28/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import UIKit

class myLabel: UILabel {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    changeFontName()
  }
  
  func changeFontName()
  {
    self.font = UIFont(name: "Giza", size: self.font.pointSize)
  }
}
