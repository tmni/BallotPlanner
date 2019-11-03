//
//  ViewModel.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/3/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import Foundation

class ViewModel {
  var electionDates = [ElectionDate]()
  
  func numberOfRows() -> Int {
    return electionDates.count
  }
  
  func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
    let row = indexPath.row
    if (row >= self.numberOfRows()) {
      return ""
    }
    else {
      let electionDate = electionDates[row]
      return electionDate.name
    }
  }
  
  func dateForRowAtIndexPath(_ indexPath: IndexPath) -> String {
    let row = indexPath.row
    
    if (row >= self.numberOfRows()) {
      return ""
    }
    else {
      let electionDate = electionDates[row]
      return electionDate.date
    }
  }
  
  
}
