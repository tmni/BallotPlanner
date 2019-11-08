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
import CoreLocation


class UserLocationController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate{
  @IBOutlet weak var locationText: UITextField!
  let location = Location()
  let db = Firestore.firestore()
  var locationManager: CLLocationManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.locationText.delegate = self
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.requestWhenInUseAuthorization()
    
    
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    let backItem = UIBarButtonItem()
//    backItem.title = "hello"
    //self.navigationItem.backBarButtonItem = nil
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .notDetermined:
      locationManager.requestAlwaysAuthorization()
      break
    case .authorizedWhenInUse:
      locationManager.startUpdatingLocation()
      self.locationText.text = "15213"
      db.collection("user").document("okabUm7jCq34tjDWHbRQ").updateData(["zip": 15213]) { err in
        if let err = err {
          print("Error writing document: \(err)")
        } else {
          print("Location zip written to ", "15213")
        }
        
      }
      
      break
    case .authorizedAlways:
      locationManager.startUpdatingLocation()
      break
    case .restricted:
      // restricted by e.g. parental controls. User can't enable Location Services
      break
    case .denied:
      // user denied your app access to Location Services, but can grant access from Settings.app
      break
    @unknown default:
      fatalError()
    }
  }
//  func canUpdateText()->Bool{
//    var userZip = self.locationText.text
//    if validZipCode(postalCode:userZip){
//    db.collection("user").document("okabUm7jCq34tjDWHbRQ")
//      .getDocument { (snapshot, error ) in
//
//        if let document = snapshot {
//          if let zipcode = document.get("zip"){
//            self.locationText.text = "\n \(String(describing: zipcode) )\n"
//          }
//
//        } else {
//
//          print("Document does not exist")
//
//        }
//    }
//
//    }}
  @IBAction func updateLocation(sender: UITextField){
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
    }
    
    
  }
  
    }
    

