//
//  CandidateViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/5/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit

class CandidateViewController: UIViewController {
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var party: UILabel!
  @IBOutlet weak var about: UILabel!
  @IBOutlet weak var twitter: UILabel!
  
  var viewModel: CandidateViewModel?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.name.text = viewModel?.title()
    self.party.text = viewModel?.party()
    self.about.text = viewModel?.about()
    self.twitter.text = viewModel?.twitter_url()
  }
}
