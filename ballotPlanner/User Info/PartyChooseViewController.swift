//
//  PartyChooseViewController.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/7/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PartyChooseController: UITableViewController {
  let db = Firestore.firestore()
  var parties = ["Democratic", "Republican", "Libertarian", "Green", "Constitution", "Independent"]
  var selectedParty = ""
  
 
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    selectedParty = parties[indexPath.row]
    updateParty()
//    print("selected section is: ", currentCell.textLabel?.text)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func updateParty(){
    db.collection("user").document("okabUm7jCq34tjDWHbRQ").updateData(["party": self.selectedParty])
    print("updated user's party to " , self.selectedParty)
  }
  

}
