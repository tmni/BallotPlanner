//
//  UserInfoController.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/5/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//
import Foundation
import UIKit

class UserInfoController: UIViewController {
  @IBOutlet weak var partyLabel: UILabel!
  @IBOutlet weak var locLabel: UILabel!
  let viewModel = UserInfoViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateLocLabel()
    updatePartyLabel()
  }
  
  func updatePartyLabel(){
    partyLabel.text = "Party: " + viewModel.getParty()
  }
  func updateLocLabel(){
    locLabel.text  = "Location: " + String(viewModel.getLocation())
  }
  
}
