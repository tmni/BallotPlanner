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
  
//  private let itemsPerRow: CGFloat = 3
//  private let sectionInsets = UIEdgeInsets(top: 50.0,
//                                           left: 20.0,
//                                           bottom: 50.0,
//                                           right: 20.0)


  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let cellNib = UINib(nibName: "CandidatesIndexCollectionViewCell", bundle: nil)
    collectionView1.register(cellNib, forCellWithReuseIdentifier: "CandidatesIndexCell")
    
    viewModel?.refresh { [unowned self] in
      DispatchQueue.main.async {
        self.collectionView1.reloadData()
        //self.collectionView1.collectionViewLayout.invalidateLayout()
      }
    }

  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailVC = segue.destination as? CandidateViewController,
      let indexPath = sender as? IndexPath {
      detailVC.viewModel = viewModel?.candidateViewModelForRowAtIndexPath(indexPath)
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel?.allCandidatesSortedByOfficeId.keys.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return viewModel?.numberOfRows() ?? 0
    //return viewModel?.allCandidates.count ?? 0
    var officeArray = Array((viewModel?.allCandidatesSortedByOfficeId.keys)!)
    if (officeArray == []) {
      return 0
    } else {
      var officeId = officeArray[section]
      var candidateArray = viewModel?.allCandidatesSortedByOfficeId[officeId]
      return candidateArray?.count ?? 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "CandidatesIndexCell", for: indexPath) as! CandidatesIndexCollectionViewCell
//    cell.name.text = viewModel?.titleForRowAtIndexPath(indexPath)
//    cell.party.text = viewModel?.partyForRowAtIndexPath(indexPath)
    var officeArray = Array(((viewModel?.allCandidatesSortedByOfficeId.keys)!))
    var officeId = officeArray[indexPath.section]
    let candidateArray = viewModel?.allCandidatesSortedByOfficeId[officeId]
    let candidate = candidateArray![indexPath.row]
    cell.name.text = candidate.first_name + " " + candidate.last_name
    cell.party.text = candidate.party_affiliation
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "toCandidateVC", sender: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    var officeArray = Array((viewModel?.allCandidatesSortedByOfficeId.keys)!)
    var text: String
    if (officeArray != []) {
      let officeId = officeArray[indexPath.section]
      text = (viewModel?.officeIdsToName[officeId])!
    } else {
      text = "Section \(indexPath.section)"
    }
    
    if let sectionHeader = collectionView1.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CandidatesIndexSectionHeader", for: indexPath) as? CandidatesIndexSectionHeader {
      sectionHeader.sectionHeaderlabel.text = text
      return sectionHeader
    }
    return UICollectionReusableView()
  }

}
