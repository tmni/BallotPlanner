//
//  CandidatesIndexSectionHeader.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/21/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import UIKit

protocol CandidatesIndexSectionHeaderDelegate:class {
  func sectionHeader(section:CandidatesIndexSectionHeader, didTappedshow button:UIButton)
}

class CandidatesIndexSectionHeader: UICollectionReusableView {
  @IBOutlet weak var sectionHeaderlabel: UILabel!
  @IBOutlet weak var button: UIButton!
  
  var popoverDescription: String = ""
  
  weak var sectionDelegate: CandidatesIndexSectionHeaderDelegate?
  
  /* Call Delegate method from button action */
  @IBAction func showButtonAction(_ sender: Any) {
    let button = sender as! UIButton
    self.sectionDelegate?.sectionHeader(section: self, didTappedshow: button)
  }
}
