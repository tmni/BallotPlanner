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
  required init?(coder aDecoder: NSCoder) {
    super.init(coder:aDecoder)
    //You Code here
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2.0)
    layer.shadowRadius = 1.0
    layer.shadowOpacity = 0.4
    layer.masksToBounds = false
   
  }
  
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

}
