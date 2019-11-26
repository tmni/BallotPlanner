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
import FirebaseUI

class UserPartyController: UIViewController{
  let db = Firestore.firestore()
  let storage = Storage.storage()
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet var parties: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadImages()
    
  }
  
  func loadImages() {
    let storageRef = storage.reference()
    let partiesRef = storageRef.child("parties")
    // Reference to an image file in Firebase Storage
    let demRef = storageRef.child("parties/democratic.jpg")
    let repRef = storageRef.child("parties/republican.png")
    let greenRef = storageRef.child("parties/green.png")
    let libRef = storageRef.child("parties/libertarian.jpg")
    let constRef = storageRef.child("parties/constitution.png")
    for button in self.parties{
      print(button.titleLabel!.text)
    }
    // Load the image using SDWebImage
    demRef.downloadURL { url, error in
      guard let url = url else { return }
      self.parties[0].sd_setBackgroundImage(with: url, for: .normal)
          }
    repRef.downloadURL { url, error in
      guard let url = url else { return }
      self.parties[1].sd_setBackgroundImage(with: url, for: .normal)
    }
    greenRef.downloadURL { url, error in
      guard let url = url else { return }
      self.parties[2].sd_setBackgroundImage(with: url, for: .normal)
    }
    libRef.downloadURL { url, error in
      guard let url = url else { return }
      self.parties[5].sd_setBackgroundImage(with: url, for: .normal)
    }
    constRef.downloadURL { url, error in
      guard let url = url else { return }
      self.parties[3].sd_setBackgroundImage(with: url, for: .normal)
    }

//    parties[0].sd_setBackgroundImage(with: demRef, for: .normal)

//    let yuh: UIImage = self.imageView

    
    // Placeholder image
//    let placeholderImage = UIImage(named: "placeholder.jpg")
    
    // Load the image using SDWebImage
//    imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
//    parties[0].setImage(self.imageView, for: UIControl.State.normal)
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
