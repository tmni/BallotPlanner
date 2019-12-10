//
//  UserPartyController.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/3/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
//import FirebaseUI

class UserPartyController: UIViewController{
  let db = Firestore.firestore()
  let storage = Storage.storage()
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet var parties: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }


  func setUserParty(party: String){
    db.collection("user").document("okabUm7jCq34tjDWHbRQ").updateData([ "party": party ])
    print("user party saved to ", party)
    
  }
  @IBAction func buttonTapped(_ sender: UIButton) {
    for party in parties {
      if party.tag == sender.tag {
        let button_name = party.titleLabel!.text!
        setUserParty(party: button_name)
        UserDefaults.standard.set(button_name, forKey: "party")
      }
    }
  }
  
}
