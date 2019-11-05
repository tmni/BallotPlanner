//
//  ElectionDatesDetailViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/3/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit

class ElectionDateDetailViewController: UIViewController {
  
  var viewModel: ElectionDateDetailViewModel?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.title = viewModel?.title()
  }
}
