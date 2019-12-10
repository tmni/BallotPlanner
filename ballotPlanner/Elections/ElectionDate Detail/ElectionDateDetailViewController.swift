//
//  ElectionDatesDetailViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/3/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit
import MapKit

class ElectionDateDetailViewController: UIViewController {
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var aboutText: UITextView!
  @IBOutlet weak var seeCandidates: UIButton!
  var electionDate: ElectionDate?
  
  var viewModel: ElectionDateDetailViewModel?
  let location = Location()
  var arrAnnotations = [MKAnnotation]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    location.getCurrentLocation()
    location.loadLocation()
    let initialLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
    centerMapOnLocation(location: initialLocation)
    //viewModel = ElectionDateDetailViewModel(electionDate: electionDate!)
    self.setAllPins()
    
    self.seeCandidates.layer.cornerRadius = 15
    self.seeCandidates.clipsToBounds = true
  }
  
  func setAllPins() {
    self.setYourPin()
    self.setVotingLocationsPins()
    mapView.showAnnotations(arrAnnotations, animated: true)
  }
  
  func setVotingLocationsPins() {
    let voting_locations = viewModel?.voting_locations()
    var count = 1
    for loc in voting_locations! {
      let lat = loc["lat"] as! CLLocationDegrees
      let long = loc["long"] as! CLLocationDegrees
      let droppedPin = MKPointAnnotation()
      droppedPin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
      droppedPin.title = "Loc" + " " + "\(count)"
      arrAnnotations.append(droppedPin)
      count = count + 1
    }
  }
  
  func setYourPin(){
    let droppedPin = MKPointAnnotation()
    droppedPin.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    droppedPin.title = "You"
    //droppedPin.subtitle = "Look it's your car!"
    arrAnnotations.append(droppedPin)
    //print("You are currently at: \n( \(location.latitude), \(location.longitude))")
  }
  
  let regionRadius: CLLocationDistance = 400
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.title = viewModel?.title()
    self.aboutText.text = viewModel?.description()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toCandidatesIndexVC" {
      if let destination = segue.destination as? CandidatesIndexViewController {
        destination.viewModel = CandidatesIndexViewModel(election: viewModel!.electionDate)
      }
    }
  }
}

