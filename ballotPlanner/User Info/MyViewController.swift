//
//  MyViewController.swift
//  ballotPlanner
//
//  Created by Taruna Emani on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit
import Firebase

class MyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
  let reuseIdentifier = "achievement" // also enter this string as the cell identifier in the storyboard
  let viewModel = AchievementViewModel()
  let viewModel2 = UserInfoViewModel()
  
  var user_info: (String, Int) = ("", 0)
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var partyLabel: UIButton!
  @IBOutlet weak var locLabel: UIButton!
  //@IBOutlet weak var locationText: UITextField!
  let location = Location()
  let db = Firestore.firestore()
  

  // MARK: - UICollectionViewDataSource protocol
  override func viewDidLoad() {
    super.viewDidLoad()
    //self.navigationItem.setHidesBackButton(true, animated: true)

    viewModel2.getUserInfo { (result) in
      self.user_info = result
      self.updatePartyLabel()
      self.updateLocLabel()
      self.viewModel.refresh { [unowned self] in
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //self.navigationItem.setHidesBackButton(true, animated: true)
    viewModel2.getUserInfo { (result) in
      self.user_info = result
      self.updatePartyLabel()
      self.updateLocLabel()
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
    let cell = collectionView.cellForItem(at: indexPath)
    var achs = viewModel.achievements
    let attributes = self.collectionView?.layoutAttributesForItem(at:indexPath)
    let cPoint = attributes?.center
    let centerPoint = collectionView.convert(cPoint!, to: collectionView.superview)
    var popover = UIStoryboard(name: "UserInfo", bundle: nil).instantiateViewController(withIdentifier: "idPopover") as! AchievementPopoverController
    popover.achTitle = achs[indexPath.item].name
    popover.achDesc = achs[indexPath.item].description
    print("User selected #\(indexPath.item)!")
  

//    popover.popoverPresentationController?.delegate = self
//    popover.preferredContentSize = CGSize(width: 340,height: 340)
    popover.modalPresentationStyle = .popover
    print("set type to popover")
    popover.popoverPresentationController?.delegate = self
    print("set delegate")
    popover.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
    print("set arrows")
    popover.popoverPresentationController?.sourceRect = cell!.bounds
    print("set rect to ", cell!.bounds)
    popover.popoverPresentationController?.sourceView = cell
    print("set source view to ", cell)
    self.present(popover,animated:true, completion:nil)
  }
  gi
  func updatePartyLabel(){
    partyLabel.layer.borderColor = UIColor.darkGray.cgColor;
    partyLabel.layer.borderWidth = 1.0;
    partyLabel.setTitle("Party: " + self.user_info.0, for: .normal)
  }
  func updateLocLabel(){
    locLabel.layer.borderColor = UIColor.darkGray.cgColor;
    locLabel.layer.borderWidth = 1.0;
    locLabel.setTitle("Location: " + String(self.user_info.1), for: .normal)
  }
  
}
extension MyViewController: UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return UIModalPresentationStyle.none
  }
}


