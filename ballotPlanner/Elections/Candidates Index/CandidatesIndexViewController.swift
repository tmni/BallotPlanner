//
//  CandidatesIndexViewController.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit

//class CandidatesIndexViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
class CandidatesIndexViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

  @IBOutlet var collectionView1: UICollectionView!
  
  var viewModel: CandidatesIndexViewModel?
  
  private let itemsPerRow: CGFloat = 3
  private let sectionInsets = UIEdgeInsets(top: 50.0,
                                           left: 20.0,
                                           bottom: 50.0,
                                           right: 20.0)


  override func viewDidLoad() {
    super.viewDidLoad()
    let cellNib = UINib(nibName: "CandidatesIndexCollectionViewCell", bundle: nil)
    collectionView1.register(cellNib, forCellWithReuseIdentifier: "CandidatesIndexCell")
    
    viewModel?.refresh { [unowned self] in
      DispatchQueue.main.async {
        self.collectionView1.reloadData()
        self.collectionView1.collectionViewLayout.invalidateLayout()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    if let selectedRow = tableView.indexPathForSelectedRow {
//      tableView.deselectRow(at: selectedRow, animated: true)
//    }
    //print(len(collectionView.indexPathsForSelectedItems))
//    if let selectedItem = collectionView.indexPathsForSelectedItems[0] {
//      collectionView.deselectItem(at: selectedItem, animated: true)
//    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailVC = segue.destination as? CandidateViewController,
      let indexPath = sender as? IndexPath {
      detailVC.viewModel = viewModel?.candidateViewModelForRowAtIndexPath(indexPath)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return viewModel?.numberOfRows() ?? 0
    return viewModel?.allCandidates.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "CandidatesIndexCell", for: indexPath) as! CandidatesIndexCollectionViewCell
    cell.name.text = viewModel?.titleForRowAtIndexPath(indexPath)
    cell.party.text = viewModel?.partyForRowAtIndexPath(indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "toCandidateVC", sender: indexPath)
  }
  
//  func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      sizeForItemAt indexPath: IndexPath) -> CGSize {
//    //2
//    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//    let availableWidth = view.frame.width - paddingSpace
//    let widthPerItem = availableWidth / itemsPerRow
//
//    return CGSize(width: widthPerItem, height: widthPerItem)
//  }
//
//  func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      insetForSectionAt section: Int) -> UIEdgeInsets {
//    return sectionInsets
//  }
//
//  func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    return sectionInsets.left
//  }
}
