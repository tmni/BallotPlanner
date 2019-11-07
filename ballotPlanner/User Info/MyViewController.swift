//
//  MyViewController.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit
class MyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  let reuseIdentifier = "achievement" // also enter this string as the cell identifier in the storyboard
  let viewModel = AchievementViewModel()
  let viewModel2 = UserInfoViewModel()
//  var user_info = (party: String, zip: Int)
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var partyLabel: UIButton!
  @IBOutlet weak var locLabel: UIButton!
  

  // MARK: - UICollectionViewDataSource protocol
  override func viewDidLoad() {
    super.viewDidLoad()
//    viewModel2.refresh{[unowned self] in
//      DispatchQueue.main.async {
//        viewModel2.reloadData()
//      }
//    }
//
    viewModel2.getUserInfo()
    
    updatePartyLabel()
    updateLocLabel()
    viewModel.refresh { [unowned self] in
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  // tell the collection view how many cells to make
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
      }
  
  // make a cell for each cell index path
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    // get a reference to our storyboard cell
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
    
    // Use the outlet in our custom class to get a reference to the UILabel in the cell
    cell.myLabel.text = viewModel.nameForRowAtIndexPath(indexPath)
    
    return cell
  }
  
  // MARK: - UICollectionViewDelegate protocol
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // handle tap events
    print("You selected cell #\(indexPath.item)!")
  }
  
  func updatePartyLabel(){
    partyLabel.layer.borderColor = UIColor.darkGray.cgColor;
    partyLabel.layer.borderWidth = 1.0;
    partyLabel.setTitle("Party: " + viewModel2.user_info.0, for: .normal)
  }
  func updateLocLabel(){
    locLabel.layer.borderColor = UIColor.darkGray.cgColor;
    locLabel.layer.borderWidth = 1.0;
    locLabel.setTitle("Location: " + String(viewModel2.user_info.1), for: .normal)
  }
  
}

