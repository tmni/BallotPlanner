//
//  MyCollectionViewCell.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit
class MyCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var myLabel: UILabel!
  required init?(coder aDecoder: NSCoder) {
    super.init(coder:aDecoder)
    //You Code here
    layer.masksToBounds = false
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    
    contentView.layer.masksToBounds = true
    layer.cornerRadius = 10
  }
  }

