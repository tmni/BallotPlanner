//
//  AchievementPopoverController.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/23/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import UIKit
class AchievementPopoverController: UIViewController {
  
    @IBOutlet weak var achTitleUI: UILabel!
    @IBOutlet weak var achDescUI: UILabel!
  
  
  
    var achTitle: String!
    var achDesc: String!
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
      achTitleUI.text = achTitle
      achDescUI.text = achDesc
    }
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
    
}
