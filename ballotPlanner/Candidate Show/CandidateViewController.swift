//
//  CandidateViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/5/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit
import WebKit
import Firebase
import FirebaseStorage
//import FirebaseUI

class CandidateViewController: UIViewController, WKNavigationDelegate {
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var party: UILabel!
  @IBOutlet weak var about: UILabel!
  @IBOutlet weak var twitter: UILabel!
  @IBOutlet weak var addToMyBallot: UIButton!
  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var imageView: UIImageView!
  
  var viewModel: CandidateViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.name.text = viewModel?.title()
    self.party.text = viewModel?.party()
    self.about.text = viewModel?.about()
    
    let twitter: String = (viewModel?.candidate.contact_twitter)!
    let webContent = """
    <a class="twitter-timeline" href="https://twitter.com/\(twitter)">Tweets by \(twitter)</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
    """
    webView.loadHTMLString(webContent, baseURL: nil)
    
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()
    
    // Create a storage reference from our storage service
    let storageRef = storage.reference()
    
    let storagePath = viewModel?.image()
    let spaceRef = storage.reference(forURL: storagePath!)
    
    // Reference to an image file in Firebase Storage
    //let reference = storageRef.child("candidates/bobby_wilson.jpeg")
    
    // UIImageView in your ViewController
    let imageView: UIImageView = self.imageView
    
    // Placeholder image
//    let placeholderImage = UIImage(named: "placeholder.jpg")
    
    // Load the image using SDWebImage
    imageView.sd_setImage(with: spaceRef)
    
    let parser = AddRemoveBallotHelper(viewModel!.candidate)
    parser.checkInBallots {
      (result) in
      if (result) {
        self.addToMyBallot.setTitle("Remove From My Ballot", for: .normal)
      } else {
        self.addToMyBallot.setTitle("Add To My Ballot", for: .normal)
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  @IBAction func addToMyBallotButtonTapped(sender: UIButton) {
    let parser = AddRemoveBallotHelper(viewModel!.candidate)
    
    parser.checkInBallots {
      (result) in
      if (result) {
        parser.removeFromMyBallot()
        self.addToMyBallot.setTitle("Add To My Ballot", for: .normal)
        let alert = UIAlertController(title: "Removed From Ballot!", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
      } else {
        parser.addToMyBallot()
        self.addToMyBallot.setTitle("Remove From My Ballot", for: .normal)
        let alert = UIAlertController(title: "Added To Ballot!", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
      }
    }
    
  }
}
