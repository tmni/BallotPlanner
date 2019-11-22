//
//  CandidateIndexViewModel.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation

class CandidatesIndexViewModel {
  var election: ElectionDate
  
  init(election: ElectionDate) {
    self.election = election
  }
  
  //var allCandidates = [Person]()
  var allCandidatesSortedByOfficeId = Dictionary<String, [Person]>()
  var officeIdsToName = Dictionary<String, String>()
  
//  func numberOfRows() -> Int {
//    return allCandidates.count
//  }
  
  //func imageForRowAtIndexPath
  
//  func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
//    let row = indexPath.row
//    if (row >= self.numberOfRows()) {
//      return ""
//    }
//    else {
//      let candidate = allCandidates[row]
//      return candidate.first_name + " " + candidate.last_name
//    }
//
//  }
//
//  func partyForRowAtIndexPath(_ indexPath: IndexPath) -> String {
//    let row = indexPath.row
//    if (row >= self.numberOfRows()) {
//      return ""
//    } else {
//      let candidate = allCandidates[row]
//      return candidate.party_affiliation
//    }
//  }
  
  func candidateViewModelForRowAtIndexPath(_ indexPath: IndexPath) -> CandidateViewModel {
    //return CandidateViewModel(candidate: allCandidates[indexPath.row])
    var officeArray = Array(allCandidatesSortedByOfficeId.keys)
    var officeId = officeArray[indexPath.section]
    var candidateArray = allCandidatesSortedByOfficeId[officeId]
    return CandidateViewModel(candidate: candidateArray![indexPath.row])
  }
  
  func refresh(_ completion: @escaping () -> Void) {
    let parser = CandidatesIndexParser(self.election)
    
//    parser.getAllCandidates {
//      (result) in self.allCandidates = result
//      completion()
//    }
    parser.getAllCandidatesSortedByOfficeId {
      (result) in self.allCandidatesSortedByOfficeId = result
      parser.getOfficeIdsToName(self.allCandidatesSortedByOfficeId) {
        (result) in self.officeIdsToName = result
        completion()
      }
    }
  }
  
}
