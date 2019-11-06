//
//  CandidatesIndexCollectionViewCell.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit

class CandidatesIndexCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var personImage: UIImageView!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var party: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

}
