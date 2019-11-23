//
//  CandidatesIndexPopoverViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/23/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import UIKit

class CandidatesIndexPopoverViewController: UIViewController {
  @IBOutlet weak var textDescription: UITextView!
  
  var textDescriptionText: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.textDescription.text = self.textDescriptionText
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}
