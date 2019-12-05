//
//  MyBallotsViewModel.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/5/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation
import Firebase

class MyBallotsViewModel {
  var election: ElectionDate
  
  init(election: ElectionDate) {
    self.election = election
  }
  
  var myBallots = [Person]()
  
  func numberOfRows() -> Int {
    return myBallots.count
  }
  
  func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
    let row = indexPath.row
    if (row >= self.numberOfRows()) {
      return ""
    }
    else {
      let myBallot = myBallots[row]
      return myBallot.first_name + " " + myBallot.last_name
    }
  }
  
  func candidateViewModelForRowAtIndexPath(_ indexPath: IndexPath) -> CandidateViewModel {
    return CandidateViewModel(candidate: myBallots[indexPath.row])
  }
  
  func refresh(_ completion: @escaping () -> Void) {
    let parser = MyBallotsParser(self.election)
    
    parser.getAllMyBallots {
      (result) in self.myBallots = result
      completion()
    }
  }
}
