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
  var locationManager1: CLLocationManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.locationText.delegate = self
    locationManager1 = CLLocationManager()
    locationManager1?.delegate = self
    locationManager1?.requestWhenInUseAuthorization()
  }
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    self.textFieldDidEndEditing(locationText)
  }
  
  // user presses return key
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    self.updateLocationManually(sender: textField)
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.resignFirstResponder()
    self.updateLocationManually(sender: textField)
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
      locationManager1.requestAlwaysAuthorization()
      break
    case .authorizedWhenInUse:
      locationManager1.startUpdatingLocation()
      self.locationText.text = "15213"
      var loc = 0
      if let text = self.locationText.text {
        if Int(text) != nil{
          loc = Int(text)! }
      }
      UserDefaults.standard.set(loc, forKey: "location")
      db.collection("user").document("okabUm7jCq34tjDWHbRQ").updateData(["zip": 15213]) { err in
        if let err = err {
          print("Error writing document: \(err)")
        } else {
          print("Location zip written to ", "15213")
        }
        
      }
      
      break
    case .authorizedAlways:
      locationManager1.startUpdatingLocation()
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
  
  @IBAction func updateLocationManually(sender: UITextField){
    var userZip = self.locationText.text
    if validZipCode(postalCode:userZip!)
    {
      if let userZip = Int((userZip)!) {
        
        UserDefaults.standard.set(userZip, forKey: "location")
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
