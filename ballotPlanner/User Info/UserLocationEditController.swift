//
//  UserLocation.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/3/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class UserLocationEditController: UIViewController, UITextFieldDelegate{
  @IBOutlet weak var locationText: UITextField!
  let location = Location()
  let db = Firestore.firestore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.locationText.delegate = self
    updateText()
    
    
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // user presses return key
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  func validZipCode(postalCode:String)->Bool{
    let postalcodeRegex = "^[0-9]{5}(-[0-9]{4})?$"
    let pinPredicate = NSPredicate(format: "SELF MATCHES %@", postalcodeRegex)
    let bool = pinPredicate.evaluate(with: postalCode) as Bool
    return bool
  }

  
  
  func updateText(){
    db.collection("user").document("okabUm7jCq34tjDWHbRQ")
      .getDocument { (snapshot, error ) in
        
        if let document = snapshot {
          if let zipcode = document.get("zip"){
            self.locationText.text = "\n \(String(describing: zipcode) )\n"
          }
          
        } else {
          
          print("Document does not exist")
          
        }
    }
    
  }
  @IBAction func updateLocation(sender: UITextField){
//    location.getCurrentLocation() //update location
//    if !(location.latitude == 0.0 && location.longitude == 0.0){
//      db.collection("user").document("okabUm7jCq34tjDWHbRQ").updateData(["zip": 15213]) { err in
//        if let err = err {
//          print("Error writing document: \(err)")
//        } else {
//          print("Location zip written")
//        }
//      }
//      //      location.saveLocation()
//    }
    var userZip = self.locationText.text
    if validZipCode(postalCode:userZip!)
    {
      if let userZip = Int((userZip)!) {
        
        
        print("converted zip to Integer ", type(of: userZip))
        db.collection("user").document("okabUm7jCq34tjDWHbRQ").updateData(["zip": userZip]) { err in
          if let err = err {
            print("Error writing document: \(err)")
          } else {
            print("Location zip written to ", userZip)
          }}}
    }
    else{
      print("Not a valid zipcode")
      let alert = UIAlertController(title: "Not a valid zipcode", message: "Please try entering a new zipcode", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
        }))
      self.present(alert, animated: true, completion: nil)
    

    }
    
    
  }
  
}
