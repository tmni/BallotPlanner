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
  @IBOutlet weak var about: UITextView!
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
    
    // UIImageView in your ViewController
    let imageView: UIImageView = self.imageView
  
    let storage = Storage.storage()
    let storageRef = storage.reference()
    let imageRef = storageRef.child((viewModel?.image())!)
    imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
      if let error = error {
        print("Error getting image: \(error)")
      } else {
        let image = UIImage(data: data!)
        imageView.image = image
      }
    }
    
    self.addToMyBallot.layer.cornerRadius = 15
    self.addToMyBallot.clipsToBounds = true
    
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
        self.addToMyBallot.setTitle("Remove From Ballot", for: .normal)
        let alert = UIAlertController(title: "Added To Ballot!", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
      }
    }
    
  }
}
