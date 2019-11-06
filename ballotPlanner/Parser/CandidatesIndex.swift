//
//  CandidatesIndex.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/6/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

class CandidatesIndexParser {
  var election: ElectionDate
  
  init(_ election: ElectionDate) {
    self.election = election
  }
  
  // loop through all candidates, get candidates that match the given election_id
  
  var allCandidates = [Candidate]()
  func getAllCandidates(completion: @escaping([Candidate]) -> Void) {
    
  }
}
